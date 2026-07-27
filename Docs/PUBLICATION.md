# Publication — Play Store & App Store

Procédure de release de `sytium_mobile`. Bundle ID / applicationId : `tech.sytium.mobile`.
Team Apple : `YF729VS8R2`. Projet Firebase : `sytium-7676a`.

---

## 1. Keystore Android (à faire une seule fois)

Le dépôt ne contient **aucune** clé. `android/key.properties` et les `.jks` sont
ignorés par git, et `bundleRelease` échoue tant que le fichier est absent —
c'est volontaire : un AAB signé en debug est rejeté par le Play Store.

```bash
keytool -genkeypair -v -keystore ~/sytium-upload.jks -storetype PKCS12 -keyalg RSA -keysize 4096 -validity 10000 -alias sytium-upload -dname "CN=Syitech Group, O=Syitech Group, L=Abidjan, C=CI"
```

`keytool` demande ensuite le mot de passe du keystore, puis celui de la clé —
**mettez le même pour les deux**, c'est ce qu'attend le Gradle d'Android.

> ⚠️ **Ce fichier et son mot de passe ne se remplacent pas.** Les perdre rend
> impossible toute mise à jour de l'application sur le Play Store. Sauvegardez
> `~/sytium-upload.jks` hors de la machine (coffre-fort d'entreprise,
> gestionnaire de mots de passe) avant de continuer.

Puis créez `android/key.properties` (jamais commité) :

```properties
storePassword=<le mot de passe choisi>
keyPassword=<le même>
keyAlias=sytium-upload
storeFile=/Users/<vous>/sytium-upload.jks
```

Empreintes à déclarer plus tard (Firebase, restriction de la clé Maps) :

```bash
keytool -list -v -keystore ~/sytium-upload.jks -alias sytium-upload
```

---

## 2. Secrets de build

Ni la clé Maps ni le keystore ne sont versionnés. La machine qui produit le
binaire doit avoir :

- `android/local.properties` → `SYTIUM_GOOGLE_MAPS_API_KEY=...`
  (sinon la carte de pointage s'affiche en **gris uni**, sans erreur)
- `ios/Flutter/Secrets.xcconfig` → voir `Secrets.xcconfig.example`
- `android/key.properties` → cf. §1

---

## 3. Commandes de build

Le temps réel ne s'active **que** par `--dart-define` : sans `REVERB_APP_KEY` et
`REVERB_HOST`, la messagerie retombe sur son polling et **les appels WebRTC n'ont
plus aucune signalisation** — rien dans l'interface ne le signale (cf. CLAUDE.md).

### Android — App Bundle de production

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://api.sytium.tech/api/v1 --dart-define=REVERB_APP_KEY=sytium-key --dart-define=REVERB_HOST=api.sytium.tech --dart-define=REVERB_PORT=443 --dart-define=REVERB_SCHEME=https --obfuscate --split-debug-info=build/symbols
```

Sortie : `build/app/outputs/bundle/release/app-release.aab`.

### iOS — archive App Store

`VOIP_ENV` doit suivre le **provisioning**, pas le mode de compilation. Une
archive App Store utilise `Runner.entitlements` (`aps-environment = production`),
donc `VOIP_ENV=production`. Un build sideloadé garde le défaut `development`.

```bash
flutter build ipa --release --dart-define=API_BASE_URL=https://api.sytium.tech/api/v1 --dart-define=REVERB_APP_KEY=sytium-key --dart-define=REVERB_HOST=api.sytium.tech --dart-define=REVERB_PORT=443 --dart-define=REVERB_SCHEME=https --dart-define=VOIP_ENV=production --obfuscate --split-debug-info=build/symbols
```

### Bêta

Mêmes commandes avec `api-beta.sytium.tech` et `REVERB_APP_KEY=sytium-beta-key`.
Pour une distribution bêta en provisioning de développement, **ne pas** passer
`VOIP_ENV=production`.

---

## 4. Numéro de version

`pubspec.yaml` → `version: <nom>+<build>`. Le **build** doit strictement
augmenter à chaque téléversement sur l'un ou l'autre store, y compris après un
rejet : un numéro déjà reçu est brûlé.

---

## 5. Déclarations obligatoires côté consoles

### Play Console

- **Formulaire « Appels et alarmes »** — l'app déclare `USE_FULL_SCREEN_INTENT`
  et `MANAGE_OWN_CALLS`. Sans ce formulaire, la fiche reste bloquée en revue.
- **Sécurité des données** — localisation précise (pointage), caméra, micro,
  photos/vidéos, contenu utilisateur, identifiants d'appareil (jeton FCM).
  Aucun partage à des tiers, aucun suivi publicitaire.
- **Suppression de compte** — https://sytium.tech/sytium/suppression-compte
- **Politique de confidentialité** — https://sytium.tech/sytium/legal#privacy

### App Store Connect

- **Étiquettes de confidentialité** — à faire correspondre à
  `ios/Runner/PrivacyInfo.xcprivacy` : Apple compare les deux déclarations.
- **Compte de démonstration** — obligatoire, l'app est entièrement derrière un
  login sans inscription possible.
- **Conformité export** — déjà couverte par `ITSAppUsesNonExemptEncryption`
  dans `Info.plist`, la question ne devrait plus être posée.

### Firebase

Play App Signing **re-signe** l'AAB avec son propre certificat. Après le premier
dépôt, récupérer le SHA-1/SHA-256 de Play App Signing dans la console Play
(Configuration → Intégrité de l'app) et l'ajouter :

- au projet Firebase (paramètres du projet → applications Android) ;
- aux restrictions de la clé Google Maps Android, **sinon la carte de pointage
  casse en production** alors qu'elle fonctionne en local.

Vérifier aussi que la **clé d'authentification APNs (.p8)** est bien téléversée
dans Firebase → Cloud Messaging, avec l'environnement production activé.

---

## 6. Ce que fait le build automatiquement

- Signature Android depuis `key.properties`, avec échec explicite si absent.
- `aps-environment` = `production` en Release, `development` en Debug/Profile
  (`RunnerDebug.entitlements`).
- Icône adaptative Android + icône monochrome de barre d'état (`ic_stat_sytium`).
- Icône App Store 1024 sans canal alpha (rejet ITMS-90717).
- `PrivacyInfo.xcprivacy` copié dans le bundle.

Les icônes sont générées à partir de `assets/images/icon.svg`. Pour les
régénérer après un changement de marque, voir l'historique du commit qui les a
introduites (script CoreGraphics, sans dépendance externe).
