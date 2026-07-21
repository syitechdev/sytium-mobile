import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/app/notifications/deferred_navigator.dart';
import 'package:sytium_mobile/app/router/app_router.dart';
import 'package:sytium_mobile/core/notifications/callkit_service.dart';
import 'package:sytium_mobile/core/notifications/device_identity.dart';
import 'package:sytium_mobile/core/notifications/device_token_registrar.dart';
import 'package:sytium_mobile/core/notifications/push_messaging_service.dart';
import 'package:sytium_mobile/core/notifications/push_payload.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/calls/application/call_controller.dart';
import 'package:sytium_mobile/features/calls/domain/call_models.dart';
import 'package:sytium_mobile/features/notifications/application/notifications_providers.dart';
import 'package:sytium_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:sytium_mobile/features/shell/application/home_tab.dart';
import 'package:sytium_mobile/features/workspace/application/active_chat_channel.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';

part 'push_notifications_coordinator.g.dart';

@Riverpod(keepAlive: true)
PushMessagingService pushMessagingService(Ref ref) {
  final service = PushMessagingService();
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(keepAlive: true)
DeviceTokenRegistrar deviceTokenRegistrar(Ref ref) =>
    DeviceTokenRegistrar(ref.watch(authDioProvider));

@Riverpod(keepAlive: true)
PushNotificationsCoordinator pushNotificationsCoordinator(Ref ref) =>
    PushNotificationsCoordinator(ref);

/// Orchestre le cycle de vie des notifications push et des appels natifs par
/// rapport à l'auth : démarre FCM après connexion (permission + tokens),
/// enregistre l'appareil (FCM + VoIP) côté backend, relaie les événements
/// CallKit (accepter/refuser) vers le [CallController], et nettoie à la
/// déconnexion.
///
/// Vit dans la couche `app/` car il relie l'infra push (core) à des features
/// (appels, notifications, router) — ce que la couche core ne doit pas faire.
class PushNotificationsCoordinator {
  PushNotificationsCoordinator(this._ref);

  final Ref _ref;
  final DeviceIdentity _identity = DeviceIdentity();

  bool _started = false;
  String? _deviceServerId;
  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _openedSub;
  StreamSubscription<CallEvent?>? _callkitSub;

  /// Construit à la première navigation : le router n'existe pas encore quand
  /// le coordinateur est instancié.
  DeferredNavigator? _deferred;

  PushMessagingService get _service => _ref.read(pushMessagingServiceProvider);
  DeviceTokenRegistrar get _registrar =>
      _ref.read(deviceTokenRegistrarProvider);

  /// À appeler à la transition vers l'état authentifié. Idempotent.
  Future<void> onAuthenticated() async {
    if (_started) return;
    _started = true;

    await _service.initialize();
    await _service.requestPermission();

    _openedSub = _service.onNotificationOpened.listen(_handleOpened);
    _tokenRefreshSub = _service.onTokenRefresh.listen((_) => _registerDevice());
    _callkitSub = FlutterCallkitIncoming.onEvent.listen(_onCallkitEvent);

    await _registerDevice();

    // Un accept survenu app terminée laisse un appel CallKit actif : on le
    // récupère et on rejoint le mesh sur ce démarrage à froid.
    await _recoverColdStartAccept();
  }

  /// À appeler à la déconnexion : désenregistre l'appareil, ferme toute UI
  /// d'appel native et coupe les écouteurs.
  Future<void> onLoggedOut() async {
    if (!_started) return;
    _started = false;

    _deferred?.cancel();
    await CallKitService.endAll();
    await _registrar.unregister(_deviceServerId);
    await _service.deleteToken();
    _deviceServerId = null;

    await _tokenRefreshSub?.cancel();
    await _openedSub?.cancel();
    await _callkitSub?.cancel();
    _tokenRefreshSub = null;
    _openedSub = null;
    _callkitSub = null;
  }

  // ---- Enregistrement device ------------------------------------------------

  Future<void> _registerDevice() async {
    final fcmToken = await _service.getToken();
    final voipToken = Platform.isIOS ? await CallKitService.voipToken() : null;
    final deviceId = await _identity.getOrCreate();

    _deviceServerId = await _registrar.register(
      deviceId: deviceId,
      fcmToken: fcmToken,
      voipToken: voipToken,
      voipEnvironment: Platform.isIOS
          ? (kReleaseMode ? 'production' : 'development')
          : null,
      // Volontairement non renseigné : `AppConfig.deviceName` est l'identifiant
      // du client ('sytium-mobile'), pas un nom d'appareil — il s'affichait tel
      // quel dans « Appareils connectés ». Sans valeur, le backend retombe sur
      // « Appareil iOS » / « Appareil Android », plus parlant.
      appVersion: '0.1.0',
    );
  }

  // ---- Pont CallKit ⇄ CallController ---------------------------------------

  Future<void> _onCallkitEvent(CallEvent? event) async {
    if (event == null) return;
    final body = _asMap(event.body);
    final extra = _asMap(body['extra']);
    final callId = (extra['call_id'] ?? body['id'])?.toString();

    switch (event.event) {
      case Event.actionCallAccept:
        await _answer(extra);
      case Event.actionCallDecline:
        if (callId != null) await _decline(callId);
      case Event.actionCallEnded:
      case Event.actionCallTimeout:
        // L'utilisateur a terminé/ignoré depuis l'UI native (CallKit) : fermer
        // aussi l'appel côté app pour que l'écran d'appel Flutter se ferme.
        // Idempotent : ne fait rien si l'appel n'est plus actif (évite la boucle
        // avec endAll() qui re-émet actionCallEnded).
        if (_ref.read(callControllerProvider).isActive) {
          await _ref.read(callControllerProvider.notifier).hangup();
        }
      case Event.actionDidUpdateDevicePushTokenVoip:
        await _registerDevice();
      // ignore: no_default_cases
      default:
        break;
    }
  }

  Future<void> _answer(Map<String, dynamic> extra) async {
    final callId = extra['call_id']?.toString();
    final channelId = extra['channel_id']?.toString();
    if (callId == null || channelId == null || channelId.isEmpty) return;

    final callerName = extra['caller_name']?.toString();
    final controller = _ref.read(callControllerProvider.notifier)
      ..handleIncoming(
        callId: callId,
        channelId: channelId,
        kind: CallKind.fromWire(extra['kind']?.toString()),
        peerName: (callerName == null || callerName.isEmpty)
            ? null
            : callerName,
      );
    await controller.acceptIncoming();
    unawaited(CallKitService.setConnected(callId));
  }

  Future<void> _decline(String callId) =>
      _ref.read(callControllerProvider.notifier).declineIncoming(callId);

  Future<void> _recoverColdStartAccept() async {
    final calls = await CallKitService.activeCalls();
    for (final raw in calls) {
      final map = _asMap(raw);
      final extra = _asMap(map['extra']);
      if (extra['call_id'] != null) {
        await _answer(extra);
        return;
      }
    }
  }

  // ---- Taps notification ----------------------------------------------------

  /// Notification tapée : rafraîchit la liste in-app puis ouvre l'écran visé.
  /// Un push de message mène à SA conversation ; tout le reste retombe sur la
  /// liste des notifications.
  void _handleOpened(RemoteMessage message) {
    _ref.invalidate(notificationsProvider);

    switch (destinationFor(PushPayload.fromData(message.data))) {
      case OpenConversation(:final channelId):
        unawaited(_openConversation(channelId));
      case OpenNotificationList():
        _navigateWhenHome((_) => const NotificationsScreen());
    }
  }

  /// Ouvre le fil du canal [channelId].
  ///
  /// `ChatThreadScreen` attend une [Conversation] complète (titre, avatar du
  /// correspondant pour un DM) alors que le push ne porte qu'un id : on la
  /// retrouve dans la liste des conversations, qui résout déjà le pair d'un DM.
  /// Un push de message n'est envoyé qu'aux membres du canal, il y est donc.
  Future<void> _openConversation(String channelId) async {
    // Déjà sur ce fil : ne pas empiler un second écran identique.
    if (_ref.read(activeChatChannelProvider) == channelId) return;

    List<Conversation> conversations;
    try {
      conversations = await _ref.read(conversationsProvider.future);
    } catch (_) {
      // Réseau coupé au moment du tap : au moins poser l'utilisateur sur la
      // messagerie, jamais sur la liste générique des notifications — il a
      // touché un message, il attend des messages.
      _openMessagesTab();
      return;
    }

    final match = conversations.where((c) => c.id == channelId).toList();
    if (match.isEmpty) {
      // Canal quitté, archivé, ou droits retirés entre l'envoi et le tap.
      _openMessagesTab();
      return;
    }
    _navigateWhenHome((_) => ChatThreadScreen(conversation: match.first));
  }

  /// Repli d'un push de message dont la conversation est introuvable : ouvrir
  /// l'onglet Messages. Aucun écran à empiler, juste l'onglet à sélectionner.
  void _openMessagesTab() {
    if (!_started) return;
    _ref.read(homeTabProvider.notifier).select(HomeTabs.messages);
  }

  /// Navigation différée jusqu'à l'accueil (cf. [DeferredNavigator]).
  DeferredNavigator get _navigator =>
      _deferred ??= DeferredNavigator(_ref.read(appRouterProvider));

  void _navigateWhenHome(WidgetBuilder builder) {
    // Déconnexion pendant la résolution de la conversation : ne rien ouvrir.
    // Sans ce garde-fou, l'écran attendrait l'accueil et s'ouvrirait chez
    // l'utilisateur SUIVANT.
    if (!_started) return;
    _navigator.push(builder);
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v));
    }
    return <String, dynamic>{};
  }
}
