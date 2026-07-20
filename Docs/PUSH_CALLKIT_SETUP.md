# Notifications push + appels natifs (CallKit / PushKit) — setup

Ce document liste les étapes **manuelles** restantes (clés, capabilities Xcode,
assets) après l'implémentation code. Le code Dart + natif est en place et
`flutter analyze` est propre.

## Architecture (rappel)

```
A appelle B  →  sytium-api
   ├─ Reverb (foreground)                → CallOverlayHost → CallKit
   └─ SendCallPushJob
        ├─ iOS  : APNs VoIP push (PushKit) → AppDelegate → showCallkitIncoming
        └─ Android : FCM data haute prio  → firebaseMessagingBackgroundHandler → showCallkitIncoming
Accept CallKit → PushNotificationsCoordinator → CallController.acceptIncoming() → mesh WebRTC (inchangé)
```

Fichiers clés mobiles :
- `lib/core/notifications/` : `push_messaging_service.dart` (FCM + notifs + handler
  background), `callkit_service.dart`, `push_payload.dart`, `device_identity.dart`,
  `device_token_registrar.dart` (POST `/mobile/devices`).
- `lib/app/notifications/push_notifications_coordinator.dart` : cycle de vie lié à
  l'auth + pont CallKit ⇄ CallController.
- `ios/Runner/AppDelegate.swift` : Firebase + PushKit VoIP + bridge CallKit.

## 1. Firebase

- Projet Firebase : **sytium-7676a** (déjà configuré).
- Android : `android/app/google-services.json` ✅ présent.
- **iOS : ajouter `ios/Runner/GoogleService-Info.plist`** (Console Firebase →
  app iOS bundle `tech.sytium.mobile` → télécharger le plist, le glisser dans
  la target Runner sous Xcode).

## 2. Xcode — capabilities (target Runner)

Signing & Capabilities → **+ Capability** :
1. **Push Notifications**
2. **Background Modes** → cocher **Voice over IP**, **Remote notifications**,
   **Audio, AirPlay, and Picture in Picture**, **Background fetch**.
   (Les clés Info.plist correspondantes sont déjà posées.)

Vérifier que l'entitlement `aps-environment` est présent (ajouté par la capability
Push Notifications ; `development` en debug, `production` en release/TestFlight).

## 3. APNs .p8 (backend)

Apple Developer → Keys → créer une clé **APNs Auth Key (.p8)**. Renseigner le
`.env` de **sytium-api** :

```
# Firebase Cloud Messaging (Android + fallback iOS)
FCM_PROJECT_ID=sytium-7676a
FCM_CREDENTIALS_PATH=/chemin/absolu/service-account.json   # Firebase → Paramètres → Comptes de service

# APNs VoIP (appels iOS via PushKit)
APNS_KEY_PATH=/chemin/absolu/AuthKey_XXXXXXXXXX.p8
APNS_KEY_ID=XXXXXXXXXX
APNS_TEAM_ID=YYYYYYYYYY
APNS_BUNDLE_ID=tech.sytium.mobile
APNS_ENVIRONMENT=development    # 'development' en debug, 'production' en prod/TestFlight
```

Un worker de queue doit tourner pour l'envoi : `php artisan queue:work`.

## 4. Assets iOS

- `AppDelegate` / CallKit référence `iconName: 'CallKitLogo'`. Ajouter une image
  **CallKitLogo** (40×40 pt, template) dans `ios/Runner/Assets.xcassets`, sinon
  l'icône d'appel n'apparaît pas (non bloquant).

## 5. Build

Déjà fait / validé : Podfile + projet en **iOS 15.0** (Firebase 12.x l'exige),
`pod install` OK (32 pods), et les deux builds passent :
`flutter build ios --debug --no-codesign` ✅ et `flutter build apk --debug` ✅.

```bash
# pod install exige une locale UTF-8 (sinon Encoding::CompatibilityError) :
cd ios && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pod install --repo-update && cd ..

flutter run --dart-define=API_BASE_URL=https://api-beta.sytium.tech/api/v1 \
            --dart-define=REVERB_APP_KEY=... --dart-define=REVERB_HOST=...
```

> Note Swift : dans `AppDelegate.swift`, le type APNs est qualifié `Foundation.Data`
> car `import flutter_callkit_incoming` expose aussi un type `Data` (ambiguïté).

## 6. Tests device réel (checklist)

Pour chaque plateforme, appeler un utilisateur B et vérifier B dans 3 états :
- **App au premier plan** → CallKit s'affiche (via Reverb + push, dédupliqués).
- **App en arrière-plan** → CallKit plein écran.
- **App tuée + téléphone verrouillé** → sonnerie + écran d'appel natif ; Accepter
  lance l'app et rejoint le mesh ; Refuser notifie le backend.
- Annulation par l'appelant avant réponse → l'écran CallKit de B se ferme.
- Nouveau message app en fond → notification FCM.

## Limite connue (v1)

Refus d'un appel **app tuée sur iOS** : CallKit ferme l'appel nativement mais la
notification de refus au backend peut ne pas partir (pas d'isolate Dart réveillé
sur un decline PushKit). Le backend marque l'appel *missed* au timeout de la
sonnette côté appelant. Amélioration future : persister l'action dans
`UserDefaults` côté natif et la rejouer au prochain lancement (pattern Flok).
