# CLAUDE.md — Sytium Mobile

> Application mobile compagnon de l'ERP **Sytium** (groupe SYITECH). Ce fichier est le
> contrat de référence du projet : stack, architecture, design system et standards de
> qualité. Il a la priorité la plus haute sur toute autre directive générale.
> Garde-le comme source de vérité ; le détail visuel exact vit dans `lib/theme/`.

## 1. Projet & objectif

- **Nom** : `sytium_mobile`
- **Quoi** : version mobile de l'ERP Sytium, compagnon de la plateforme web (Laravel + React).
- **Périmètre v1 — trois domaines uniquement** :
  1. **Stats / Tableaux de bord** : consultation des indicateurs consolidés (CA, trésorerie,
     recouvrement, masse salariale, projets, RH…) avec graphes équivalents au web.
  2. **Mon espace (employé)** : profil, contrat & poste, rémunération, paie & bulletins,
     documents, permissions/missions, évaluations, demandes.
  3. **Messagerie intégrée** : canaux, messages directs, mentions, fonctions IA (résumé,
     extraction de tâches, compte-rendu).
- **Hors périmètre v1** : création/édition de données métier lourdes (facturation, saisie
  comptable). Le mobile est d'abord **consultation + collaboration**, pas un poste de saisie.
- **Cible** : iOS + Android. Mobile-first (téléphone), tablette en bonus (layouts adaptatifs).

## 2. Stack figée (contrats — ne pas dévier sans validation)

- **Flutter** (stable récente), **Dart** null-safe, mode strict.
- **State / DI** : **Riverpod** (riverpod 2, `@riverpod` codegen). Pas de setState pour la
  logique métier ; uniquement pour de l'état d'animation purement local.
- **Navigation** : **go_router** (routes typées, deep links, guards d'auth).
- **Réseau** : **dio** + intercepteurs (auth bearer, refresh, logging, gestion d'erreur
  centralisée) ; client typé par feature (repository pattern).
- **Modèles** : **freezed** + **json_serializable** (immutables, `copyWith`, unions pour les
  états). Aucun `Map<String,dynamic>` qui fuit hors de la couche data.
- **Graphes** : **fl_chart** (barres, lignes, camemberts/donuts) thématisé via le design
  system. (Syncfusion seulement si un graphe complexe l'exige et après validation licence.)
- **Format** : **intl** (locale `fr_FR`) pour montants FCFA, dates, nombres.
- **Thème** : `ThemeMode` (système/clair/sombre) géré par Riverpod et **persisté** (shared_preferences),
  branché sur `MaterialApp.themeMode`. Les deux ThemeData dérivent des mêmes tokens (`lib/theme/`).
- **Stockage sécurisé** : `flutter_secure_storage` pour le token. **Jamais** de token en clair
  dans SharedPreferences ni dans les logs.
- **Cache data** : Riverpod (avec invalidation) ; `dio_cache_interceptor` pour le cache HTTP
  des écrans de consultation (le mobile doit rester lisible en réseau dégradé).

## 3. Architecture (feature-first, strictement en couches)

```
lib/
├── app/                 # bootstrap, router, thème, observers Riverpod
├── core/                # erreurs, réseau (dio), résultats, extensions, utils (Money, Dates)
├── theme/               # tokens.dart + theme.dart (SOURCE DE VÉRITÉ design) + widgets/ partagés
├── features/
│   ├── auth/
│   ├── dashboard/       # stats & graphes
│   ├── employee_space/  # "Mon espace"
│   └── messaging/       # messagerie + IA
└── shared/              # widgets transverses (états, KPI tile, app_scaffold, charts wrappers)
```
Chaque feature : `data/` (dto + repository + datasource) · `domain/` (entités + interfaces)
· `application/` (providers Riverpod) · `presentation/` (écrans + widgets). La couche
presentation ne touche jamais dio directement.

## 4. Contrat API (backend Laravel)

- Base : `/api/v1`, JSON, ressources `JsonResource`. Auth par **token Bearer** (Sanctum/Passport).
- Toute liste est **paginée** (`data`, `meta`, `links`) — le mobile gère le scroll infini.
- Codes : 200/201/204, 401 (→ déconnexion/refresh), 403, 404, 409, 422 (erreurs de champ).
- **Les types Dart sont dérivés des réponses réelles**, jamais inventés. Si le contrat d'un
  endpoint est inconnu, demande-le ou propose un DTO marqué `// TODO(contract): à confirmer`
  plutôt que d'inventer une forme.
- Devise renvoyée par l'API en valeur brute (entier FCFA) ; le formatage est côté client.

## 5. Design system — identité Sytium (le cœur de la qualité premium)

> Tokens implémentés dans `lib/theme/tokens.dart` et exposés via `theme.dart` (clair + sombre).
> **Règle absolue : aucune valeur de style en dur dans les widgets.** Couleurs, espacements,
> rayons, typographies, ombres viennent EXCLUSIVEMENT des tokens. Un `Color(0xFF…)` ou un
> `EdgeInsets.all(13)` magique dans un écran = bug à corriger.

### Marque (dérivée de la plateforme web — à aligner sur les tokens web exacts)
- **Emerald / brand** `#13B98A` — couleur de marque : accents, états actifs, "en ligne", CTA secondaires positifs.
- **Indigo / IA** `#6D5EF6` — **réservé aux fonctions IA** (Aide IA, Sytium IA, résumés). Ne jamais l'utiliser pour de l'UI non-IA.
- **Navy chrome** `#0A1730` — chrome sombre (barres, en-têtes, fonds premium), proche du sidebar web.

> **Branding par organisation (cohérence avec le web `/admin/mon-organisation`).** La couleur de
> marque et le chrome sont **dynamiques, dérivés de l'organisation connectée** : `accent_color` →
> **brand** (CTA, états actifs, liens), `primary_color` → **chrome**. Les valeurs ci-dessus (emerald
> `#13B98A`, navy `#0A1730`) sont les **défauts/fallback Sytium** (avant login ou si l'org ne définit
> pas de couleurs). Les **surfaces restent neutres** (cf. §Surfaces) dans les deux thèmes pour la
> lisibilité ; le `onBrand` est calculé par luminance. Implémenté via `theme/branding.dart` +
> `app/theme/branding_provider.dart` ; `AppTheme.light/dark([Branding])`. La **typo par org est
> différée** (le mobile garde Inter/Space Grotesk bundlés). L'indigo IA reste réservé, non brandé.

### Surfaces
- Clair : fond `#F7F8FA`, carte `#FFFFFF`, bordure `#E7E9EE`, texte `#0F172A`, texte secondaire `#64748B`.
- Sombre : fond `#0E0F12`, surface `#16181D`, bordure `#262A31`, texte `#F8FAFC`, secondaire `#94A3B8`.
- **Les deux thèmes couvrent l'application ENTIÈRE** (dashboard, mon espace, messagerie, profil, dialogs,
  graphes…), pas seulement la messagerie. Chaque surface, texte et graphe a sa valeur dans les deux thèmes.

### Sémantique
- success `#16A34A` · warning `#D97706` · danger `#DC2626` · info `#2563EB`.
- KPI : valeurs positives en emerald, alertes/dettes en danger (cf. captures dashboard).

### Data-viz (palette de graphes, ordre stable)
`[ navy #0A1730, emerald #13B98A, indigo #6D5EF6, amber #F59E0B, sky #38BDF8, rose #FB7185 ]`
Les graphes mobiles reprennent l'esprit web (barres navy, courbes emerald, donuts multicolores)
mais **repensés pour l'écran étroit** : pas de transposition 1:1 d'un dashboard desktop.

### Typographie
- 2 rôles : **display** (titres, grotesque caractérielle) + **body** (Inter ou équivalent neutre).
  Mono pour montants/chiffres si lisibilité (tabular figures obligatoires sur les nombres).
- Hiérarchie par le poids et l'espace, pas par l'empilement de tailles. Sentence case.

### Échelle, rayon, élévation
- Espacement : multiples de 4 (`4, 8, 12, 16, 24, 32, 48`). Échelle stricte.
- Rayon : `sm 8 · md 12 · lg 16 · pill 999`. Cohérent par famille de composant.
- Élévation discrète : l'ombre signale l'élévation, pas la décoration. Pas d'ombres lourdes.

### Thèmes & bascule (toute l'application)
- L'app supporte **trois modes** : `système` (suit l'OS), `clair`, `sombre`. Le mode est
  **choisi par l'utilisateur** et **persisté** (relancement = même choix). Défaut : `système`.
- Implémentation : un `ThemeMode` géré par un provider Riverpod (`themeModeProvider`), persisté
  (shared_preferences), branché sur `MaterialApp.themeMode` avec `theme:` (clair) et `darkTheme:` (sombre).
  Les deux ThemeData sont construits depuis les MÊMES tokens (`lib/theme/`), jamais codés en dur.
- **Sélecteur de thème** accessible depuis Profil/Réglages (segmented control : Système · Clair · Sombre).
- Aucune feature n'impose son propre thème. La messagerie n'est PAS « sombre en dur » : elle suit le
  thème global comme le reste (elle reste simplement très soignée en sombre).
- Les couleurs dépendantes du thème se lisent via `Theme.of(context)` / l'extension de tokens, jamais
  par un `if (isDark)` dispersé dans les widgets.

### Format FCFA / dates (utilitaire `Money` dans core)
- Montants : groupage par espace, **0 décimale**, suffixe ` FCFA` → `145 092 130 FCFA`.
  Implémente via `NumberFormat.decimalPattern('fr_FR')`. Jamais de formatage ad hoc dans un widget.
- Dates : locale `fr_FR` (`26/06/2026`, `26 juin 2026` selon contexte).

## 6. Contrat UI mobile (premium, pas un portage web)

- **Navigation** : `BottomNavigationBar` (ou NavigationBar M3 custom) à 3–4 entrées
  (Tableau de bord · Mon espace · Messagerie · Profil). Le sidebar web NE se transpose PAS tel quel.
- **Les 4 états sont obligatoires** sur tout écran de données :
  - `loading` : **shimmer/skeleton** calqué sur la forme du contenu (jamais un spinner nu centré).
  - `empty` : message + action ("Aucune notification.").
  - `error` : cause lisible + bouton réessayer. Gère explicitement la perte réseau.
  - `success` : le contenu.
- **Feel premium** : transitions fluides (page transitions cohérentes), `Hero` quand pertinent,
  **retour haptique** sur actions clés, `prefers reduced motion` respecté, pull-to-refresh sur les
  écrans de stats, scroll infini paginé sur les listes.
- **Graphes** : titres + légende lisibles au pouce, valeurs formatées FCFA, tooltips au tap,
  responsive (jamais coupés), placeholders skeleton pendant le chargement.
- **Thème global commutable** : clair et sombre tous deux soignés et complets sur TOUT écran. La bascule
  utilisateur (Système/Clair/Sombre) est persistée. Tester chaque écran dans les deux thèmes (cf. §5).
- **Accessibilité** : contraste AA, cibles ≥ 44px, `Semantics` sur les éléments interactifs,
  textes scalables (respect du textScaleFactor).
- **Composants partagés d'abord** : avant de coder un écran, vérifie/étends la lib maison
  (`shared/widgets`) : `AppScaffold`, `KpiTile`, `SectionCard`, `EmptyState`, `ErrorState`,
  `AppChart*`, `Avatar`, `Badge`. La cohérence vient de cette lib réutilisée, pas de copier-coller.

## 7. Exigences par domaine

### Tableau de bord / stats
- KPI en grille 2 colonnes (ou carrousel), groupés par bloc (Finance, RH, Projets, Commercial…).
- Graphes : évolution CA (barres), comparaison 2025/2026, top clients/produits (barres horizontales),
  répartition (donut), recettes (ligne). Filtre de période. Données via repository + cache.

### Mon espace (employé)
- En-tête profil (avatar, nom, fonction, statut "Actif"), puis sections : Identité, Contrat & Poste,
  Rémunération (montants FCFA), Contacts, et onglets Paie & Bulletins, Documents, Permissions/Missions,
  Évaluations, Demandes. Export "fiche PDF" via l'API (téléchargement). Données sensibles : pas de log.

### Messagerie (thème sombre)
- Liste des canaux + DM, fil de discussion, composer (mentions, pièces jointes), statut en ligne (emerald),
  panneau IA (indigo) : résumer, extraire les tâches, détecter décisions, compte-rendu. Temps réel via
  WebSocket si dispo, sinon polling avec indicateur "temps réel dégradé". Messages supprimés gérés proprement.

## 8. Qualité de code — non négociable

- Null safety strict, **zéro `dynamic`** hors couche de désérialisation. Pas de `!` non justifié.
- Gestion d'erreur typée : `Result`/`Either` ou exceptions mappées ; aucun `catch` silencieux.
- Pas de logique métier dans les widgets. Widgets `const` partout où possible (perf).
- Pas de secret/URL en dur : `--dart-define` / config d'environnement.
- Listes : `ListView.builder` + pagination ; jamais de rendu de liste complète non virtualisée.
- Dispose systématique des controllers/streams/animations (pas de fuite).

## 9. Tests & boucle visuelle

- **Tests** : unitaires (logique, formatters, mapping DTO), widget tests des 4 états par écran,
  et **golden tests** sur les composants clés (KPI tile, graphes, message bubble) pour verrouiller
  le rendu premium et détecter les régressions visuelles.
- **Boucle visuelle** (Flutter n'a pas d'équivalent Playwright) : lance l'app sur simulateur,
  prends un screenshot, **regarde le rendu réel et itère** — une image vaut 1000 tokens. Ne te fie
  pas au code seul pour juger l'UI. Les goldens servent de filet anti-régression ensuite.

## 10. Commandes

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed / json / riverpod / retrofit
flutter analyze                                             # lints (very_good_analysis recommandé)
dart format .
flutter test                                                # + golden tests
flutter run --dart-define=API_BASE_URL=...                  # lancer sur simulateur
```

### Builds de distribution — le temps réel ne s'active QUE par `--dart-define`

`RealtimeConfig.isConfigured` exige `REVERB_APP_KEY` **et** `REVERB_HOST`
(`lib/features/workspace/realtime/realtime_config.dart`). Un `flutter build` sans
ces defines compile une application où la couche live est un no-op silencieux :
la messagerie retombe sur son polling, mais **les appels WebRTC n'ont plus aucune
signalisation** — l'offre SDP part et personne ne la reçoit, l'appel ne se
connecte jamais. Rien dans l'interface ne le signale. Toujours builder ainsi :

```bash
flutter build apk --release \
  --dart-define=API_BASE_URL=https://api-beta.sytium.tech/api/v1 \
  --dart-define=REVERB_APP_KEY=<REVERB_APP_KEY du .env backend> \
  --dart-define=REVERB_HOST=api-beta.sytium.tech \
  --dart-define=REVERB_PORT=443 \
  --dart-define=REVERB_SCHEME=https
```

La clé doit être **identique** à celle du `.env` backend et à la variable GitHub
`VITE_REVERB_APP_KEY_BETA` du front : c'est le même serveur Reverb pour les trois
clients. Elle est publique (elle est livrée à chaque client) ; le
`REVERB_APP_SECRET` ne quitte jamais le serveur.

### iOS : `VOIP_ENV` doit suivre le PROVISIONING, jamais le mode de compilation

`AppConfig.voipEnvironment` (`--dart-define=VOIP_ENV`, défaut `development`) est
déclaré au backend pour choisir l'hôte APNs. Il DOIT correspondre à
l'environnement de provisioning iOS réel, PAS à `--release` :

- **Sideload / ad hoc / TestFlight interne** (entitlement `aps-environment=development`,
  token VoIP **sandbox**) → laisser le défaut `development`. **Ne PAS** passer
  `VOIP_ENV=production`, même en `--release`.
- **App Store / TestFlight en provisioning production** → `--dart-define=VOIP_ENV=production`.

Piège corrigé le 23/07/2026 : la valeur était dérivée de `kReleaseMode`, donc un
build `--release` sideloadé déclarait `production` → push VoIP envoyé sur l'APNs
production avec un token sandbox → `BadDeviceToken` → le serveur **purge le
voip_token** → l'iPhone ne sonne plus, appli fermée/verrouillée (« le premier
appel n'arrive jamais »).

## 11. Definition of Done (cocher avant de livrer une feature)

- [ ] Données via repository + DTO freezed dérivés du contrat réel ; cache + pagination si liste
- [ ] Providers Riverpod, zéro logique métier dans la presentation
- [ ] UI à partir des composants partagés ; tokens uniquement, zéro valeur en dur
- [ ] Les 4 états présents et soignés (shimmer/empty/error/success) + pull-to-refresh si pertinent
- [ ] Montants FCFA et dates formatés via les utilitaires (fr_FR)
- [ ] **Clair + sombre vérifiés sur l'écran** (les deux thèmes complets) ; bascule de thème persistée OK ; a11y (contraste, cibles, Semantics) OK
- [ ] Tests unit + widget (4 états) + golden sur composants clés au vert ; `flutter analyze` propre
- [ ] Rendu vérifié sur simulateur (screenshot) ; aucun TODO sans préfixe de scope, aucun mock résiduel
