import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sytium_mobile/core/notifications/callkit_service.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';

/// Canal Android par défaut. DOIT correspondre à la `meta-data`
/// `com.google.firebase.messaging.default_notification_channel_id` déclarée
/// dans `android/app/src/main/AndroidManifest.xml`, sinon les notifications
/// reçues app fermée/arrière-plan retombent sur un canal muet.
const AndroidNotificationChannel _defaultChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'Notifications importantes',
  description:
      'Alertes et messages Sytium (approbations, messagerie, rappels).',
  importance: Importance.high,
);

/// Handler exécuté quand un message FCM arrive alors que l'app est en
/// arrière-plan ou terminée. Tourne dans un isolate dédié : il doit
/// ré-initialiser Firebase et ne partage aucun état avec l'app.
///
/// Sur Android, un message *notification* est affiché par le système via le
/// canal par défaut ; ce handler ne sert qu'aux messages *data-only* et à un
/// éventuel traitement de fond (pas d'accès à l'UI ici).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // Appels entrants (Android) : lever l'UI CallKit plein écran même app tuée.
  // (iOS passe par PushKit natif dans AppDelegate, pas par ce handler.)
  final payload = PushPayload.fromData(message.data);
  switch (payload.kind) {
    case PushKind.incomingCall:
      await CallKitService.showIncoming(payload);
    case PushKind.callCancelled:
      if (payload.callId != null) await CallKitService.end(payload.callId!);
    case PushKind.message:
    case PushKind.unknown:
      // Message notification affiché par le système ; rien à faire ici.
      if (kDebugMode) {
        debugPrint('[FCM] background message: ${message.messageId}');
      }
  }
}

/// Encapsule Firebase Cloud Messaging + l'affichage des notifications locales.
///
/// Responsabilités : permission, récupération/rafraîchissement du token,
/// affichage des messages reçus au premier plan (Android n'affiche pas
/// automatiquement les notifications foreground), et exposition des taps de
/// notification pour la navigation. L'enregistrement du token côté backend est
/// délégué à l'appelant (couche application) — ce service ne connaît pas l'API.
class PushMessagingService {
  PushMessagingService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  final StreamController<RemoteMessage> _openedController =
      StreamController<RemoteMessage>.broadcast();

  bool _initialized = false;
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  /// Émet à chaque fois qu'une notification est tapée (app en fond ou lancée
  /// via la notification). À écouter par la couche navigation.
  Stream<RemoteMessage> get onNotificationOpened => _openedController.stream;

  /// Le token FCM se rafraîchit périodiquement ; l'appelant doit ré-enregistrer
  /// la nouvelle valeur côté backend.
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  /// Initialise les notifications locales, le canal Android, les options de
  /// présentation iOS et les écouteurs de messages. Idempotent.
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    // --- Notifications locales (affichage foreground + tap) ---
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    // La permission iOS est demandée via FirebaseMessaging.requestPermission ;
    // on évite de la redemander ici pour ne pas doubler le prompt.
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: androidInit,
        iOS: darwinInit,
      ),
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_defaultChannel);

    // iOS : afficher bannière + son quand un message arrive au premier plan.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // --- Écouteurs de messages ---
    _subscriptions
      ..add(FirebaseMessaging.onMessage.listen(_onForegroundMessage))
      ..add(FirebaseMessaging.onMessageOpenedApp.listen(_openedController.add));

    // App lancée depuis l'état terminé via une notification.
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _openedController.add(initial);
    }
  }

  /// Demande l'autorisation d'envoyer des notifications (prompt système sur
  /// iOS et Android 13+).
  Future<NotificationSettings> requestPermission() {
    return _messaging.requestPermission();
  }

  /// Token de l'appareil pour cibler cet appareil via FCM. `null` si
  /// indisponible (permission refusée, APNs non prêt sur iOS…).
  Future<String?> getToken() => _messaging.getToken();

  /// Invalide le token courant (à appeler à la déconnexion pour ne plus
  /// recevoir de push destinés à l'utilisateur précédent).
  Future<void> deleteToken() => _messaging.deleteToken();

  /// Affiche une notification locale à partir d'un message reçu au premier
  /// plan. Android n'affiche pas les notifications FCM en foreground : on les
  /// rend nous-mêmes via le canal par défaut.
  Future<void> _onForegroundMessage(RemoteMessage message) async {
    // Pushs d'appel : rendu par l'UI native CallKit, jamais en notif locale.
    final payload = PushPayload.fromData(message.data);
    if (payload.kind == PushKind.incomingCall) {
      await CallKitService.showIncoming(payload);
      return;
    }
    if (payload.kind == PushKind.callCancelled) {
      if (payload.callId != null) await CallKitService.end(payload.callId!);
      return;
    }

    final notification = message.notification;
    if (notification == null) return; // message data-only : pas de rendu.

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _defaultChannel.id,
          _defaultChannel.name,
          channelDescription: _defaultChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      // Transmet TOUT le payload de données, pas seulement la route : c'est lui
      // qui porte `type` et `channel_id`, donc la capacité d'ouvrir la bonne
      // conversation au tap.
      payload: encodePushData(message.data),
    );
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    // Reconstruit un RemoteMessage pour partager le même canal de navigation
    // que onMessageOpenedApp : un tap au premier plan et un tap en arrière-plan
    // doivent mener au même écran.
    _openedController.add(RemoteMessage(data: decodePushData(response.payload)));
  }

  Future<void> dispose() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
    await _openedController.close();
  }
}
