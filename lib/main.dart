import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sytium_mobile/app/app.dart';
import 'package:sytium_mobile/core/notifications/push_messaging_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase lit sa config depuis les fichiers natifs (google-services.json /
  // GoogleService-Info.plist) ; aucune option/secret n'est portée en Dart.
  await Firebase.initializeApp();
  // Doit être enregistré avant runApp : gère les messages reçus app en fond
  // ou terminée (isolate dédié).
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await initializeDateFormatting('fr_FR');
  runApp(const ProviderScope(child: App()));
}
