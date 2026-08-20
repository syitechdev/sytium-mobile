import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sytium_mobile/core/upload/upload_providers.dart';
import 'package:sytium_mobile/features/employee_space/application/employee_space_providers.dart';
import 'package:sytium_mobile/features/employee_space/data/dtos/employee_space_dtos.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

/// « Mon espace » — version minimaliste.
///
/// Quatre choses, celles qu'un salarié ouvre depuis son téléphone : sa fiche,
/// ses bulletins, ses documents personnels et le règlement intérieur. Le web en
/// porte douze onglets ; les recopier ici ferait un écran illisible au pouce.
class EmployeeSpaceScreen extends ConsumerWidget {
  const EmployeeSpaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mon espace'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Informations'),
              Tab(text: 'Bulletins'),
              Tab(text: 'Documents'),
              Tab(text: 'Règlement'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _InformationsTab(),
            _PayslipsTab(),
            _DocumentsTab(),
            _RegulationTab(),
          ],
        ),
      ),
    );
  }
}

// ── Informations ────────────────────────────────────────────────────────────

class _InformationsTab extends ConsumerWidget {
  const _InformationsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(myProfileProvider);

    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _Message(
        texte: 'Fiche indisponible pour le moment.',
        onRetry: () => ref.invalidate(myProfileProvider),
      ),
      data: (profile) {
        if (profile == null) {
          return const _Message(
            texte: "Aucune fiche salarié n'est rattachée à ce compte.",
          );
        }

        return ListView(
          padding: const EdgeInsets.all(Tokens.space16),
          children: [
            _Entete(profile: profile),
            const SizedBox(height: Tokens.space16),
            _Bloc(
              titre: 'Identité',
              lignes: [
                ('Date de naissance', _jour(profile.identite.dateNaissance)),
                ('Lieu de naissance', profile.identite.lieuNaissance),
                ('Sexe', profile.identite.sexe),
                ('Situation matrimoniale', profile.identite.situationMatrimoniale),
                ('Nationalité', profile.identite.nationalite),
                ('Dernier diplôme', profile.identite.dernierDiplome),
              ],
            ),
            _Bloc(
              titre: 'Contrat & poste',
              lignes: [
                ("Date d'entrée", _jour(profile.contrat.dateEmbauche)),
                ('Type de contrat', profile.contrat.typeContrat),
                ('Fonction', profile.contrat.fonction),
                ('Poste', profile.contrat.poste),
                ('Département', profile.contrat.departement),
                ('Catégorie', profile.contrat.categorieSalariale),
                ('N° CNPS', profile.contrat.numeroCnps),
              ],
            ),
            _Bloc(
              titre: 'Rémunération',
              lignes: [
                ('Salaire de base', _montant(profile.remuneration.salaireBase)),
                if (profile.remuneration.sursalaire > 0)
                  ('Sursalaire', _montant(profile.remuneration.sursalaire)),
                if (profile.remuneration.salaireNetActuel > 0)
                  ('Salaire net actuel', _montant(profile.remuneration.salaireNetActuel)),
              ],
            ),
            _Bloc(
              titre: 'Contacts',
              lignes: [
                ('Téléphone', profile.contacts.telephone),
                ('Email', profile.contacts.email),
                ('Adresse', profile.contacts.adresse),
                ('Personne à contacter', profile.contacts.contactUrgenceNom),
                ("Contact d'urgence", profile.contacts.contactUrgenceTelephone),
                ('Lien', profile.contacts.contactUrgenceLien),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Entete extends StatelessWidget {
  const _Entete({required this.profile});

  final EmployeeProfileDto profile;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final nomComplet = '${profile.nom} ${profile.prenoms ?? ''}'.trim();

    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: colors.card,
          backgroundImage:
              profile.photoUrl == null || profile.photoUrl!.isEmpty
              ? null
              : NetworkImage(profile.photoUrl!),
          child: profile.photoUrl == null || profile.photoUrl!.isEmpty
              ? Text(
                  nomComplet.isEmpty ? '?' : nomComplet.characters.first,
                  style: theme.titleLarge,
                )
              : null,
        ),
        const SizedBox(width: Tokens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nomComplet, style: theme.titleMedium),
              if (profile.matricule != null)
                Text(
                  'Mat. ${profile.matricule}',
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
              if (profile.contrat.fonction != null)
                Text(
                  profile.contrat.fonction!,
                  style: theme.bodySmall?.copyWith(color: colors.textMuted),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Bulletins ───────────────────────────────────────────────────────────────

class _PayslipsTab extends ConsumerWidget {
  const _PayslipsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final colors = context.colors;
    final payslipsAsync = ref.watch(myPayslipsProvider);

    return payslipsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _Message(
        texte: 'Bulletins indisponibles pour le moment.',
        onRetry: () => ref.invalidate(myPayslipsProvider),
      ),
      data: (payslips) {
        if (payslips.isEmpty) {
          return const _Message(texte: 'Aucun bulletin validé pour l’instant.');
        }

        return ListView.separated(
          padding: const EdgeInsets.all(Tokens.space16),
          itemCount: payslips.length,
          separatorBuilder: (_, _) => const SizedBox(height: Tokens.space8),
          itemBuilder: (context, index) {
            final p = payslips[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(Tokens.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_periode(p.periode), style: theme.titleSmall),
                        Text(
                          _montant(p.netToPay) ?? '—',
                          style: theme.titleSmall?.copyWith(
                            color: colors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Tokens.space8),
                    _LigneChiffre(libelle: 'Salaire brut', valeur: p.gross),
                    _LigneChiffre(
                      libelle: 'Retenues salariales',
                      valeur: -p.deductions,
                    ),
                    _LigneChiffre(libelle: 'Net à payer', valeur: p.netToPay, gras: true),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _LigneChiffre extends StatelessWidget {
  const _LigneChiffre({
    required this.libelle,
    required this.valeur,
    this.gras = false,
  });

  final String libelle;
  final double valeur;
  final bool gras;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final style = gras
        ? theme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)
        : theme.bodySmall?.copyWith(color: colors.textMuted);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Tokens.space4 / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(libelle, style: style),
          Text(_montant(valeur) ?? '—', style: style),
        ],
      ),
    );
  }
}

// ── Documents personnels ────────────────────────────────────────────────────

class _DocumentsTab extends ConsumerWidget {
  const _DocumentsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(myDocumentsProvider);

    return documentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _Message(
        texte: 'Documents indisponibles pour le moment.',
        onRetry: () => ref.invalidate(myDocumentsProvider),
      ),
      data: (documents) {
        if (documents.isEmpty) {
          return const _Message(texte: 'Aucun document personnel.');
        }

        return ListView.separated(
          padding: const EdgeInsets.all(Tokens.space16),
          itemCount: documents.length,
          separatorBuilder: (_, _) => const SizedBox(height: Tokens.space8),
          itemBuilder: (context, index) {
            final d = documents[index];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(d.nom),
                subtitle: Text(
                  [d.categorie, _jour(d.date)].whereType<String>().join(' · '),
                ),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => _ouvrir(
                  context,
                  ref,
                  path: d.storagePath,
                  bucket: d.storageBucket ?? 'employee-documents',
                  lien: d.url,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ── Règlement intérieur ─────────────────────────────────────────────────────

class _RegulationTab extends ConsumerWidget {
  const _RegulationTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final colors = context.colors;
    final regulationAsync = ref.watch(myInternalRegulationProvider);

    return regulationAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _Message(
        texte: 'Règlement indisponible pour le moment.',
        onRetry: () => ref.invalidate(myInternalRegulationProvider),
      ),
      data: (regulation) {
        if (regulation == null) {
          return const _Message(
            texte: "Aucun règlement intérieur n'est publié.",
          );
        }

        final ack = regulation.acknowledgement;

        return ListView(
          padding: const EdgeInsets.all(Tokens.space16),
          children: [
            Text(regulation.titre, style: theme.titleMedium),
            const SizedBox(height: Tokens.space4),
            Text(
              [
                if (regulation.version != null) 'Version ${regulation.version}',
                if (regulation.publishedAt != null)
                  'Publié le ${_jour(regulation.publishedAt)}',
              ].join(' · '),
              style: theme.bodySmall?.copyWith(color: colors.textMuted),
            ),
            if (regulation.description != null &&
                regulation.description!.isNotEmpty) ...[
              const SizedBox(height: Tokens.space12),
              Text(regulation.description!, style: theme.bodyMedium),
            ],
            const SizedBox(height: Tokens.space16),
            FilledButton.icon(
              onPressed: () => _ouvrir(
                context,
                ref,
                path: regulation.storagePath,
                bucket: regulation.storageBucket ?? 'internal-regulations',
                lien: null,
              ),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Ouvrir le règlement'),
            ),
            const SizedBox(height: Tokens.space16),
            // L'accusé est une trace juridique : on l'affiche, on ne le crée
            // pas au passage d'un écran de consultation.
            Card(
              child: ListTile(
                leading: Icon(
                  ack?.signedAt != null
                      ? Icons.verified_outlined
                      : Icons.pending_outlined,
                  color: ack?.signedAt != null ? colors.success : colors.warning,
                ),
                title: Text(
                  ack?.signedAt != null
                      ? 'Vous avez signé ce règlement'
                      : 'Signature en attente',
                ),
                subtitle: Text(
                  ack?.signedAt != null
                      ? 'Le ${_jour(ack!.signedAt!.split('T').first)}'
                      : 'La signature se fait depuis un ordinateur.',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Communs ─────────────────────────────────────────────────────────────────

/// Ouvre un fichier de la plateforme.
///
/// Toujours par une signature FRAÎCHE : une adresse enregistrée avec le fichier
/// porte la signature du jour du dépôt, périmée quelques minutes plus tard.
Future<void> _ouvrir(
  BuildContext context,
  WidgetRef ref, {
  required String? path,
  required String bucket,
  required String? lien,
}) async {
  final messenger = ScaffoldMessenger.of(context);

  Future<void> lancer(String url) async {
    final ouvert = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!ouvert) {
      messenger.showSnackBar(
        const SnackBar(content: Text("Aucune application ne peut l'ouvrir.")),
      );
    }
  }

  if (path == null || path.isEmpty) {
    if (lien != null && lien.isNotEmpty) {
      await lancer(lien);
      return;
    }
    messenger.showSnackBar(
      const SnackBar(content: Text('Ce document n’a pas de fichier joint.')),
    );
    return;
  }

  final signed = await ref
      .read(uploadRepositoryProvider)
      .signedUrl(path: path, bucket: bucket);
  final url = signed.valueOrNull;

  if (url == null || url.isEmpty) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          signed.failureOrNull?.message ??
              "Ce document n'est pas consultable pour le moment.",
        ),
      ),
    );
    return;
  }

  await lancer(url);
}

class _Bloc extends StatelessWidget {
  const _Bloc({required this.titre, required this.lignes});

  final String titre;

  /// Couples libellé / valeur. Une valeur vide n'est pas affichée : une liste
  /// de tirets ne renseigne personne.
  final List<(String, String?)> lignes;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final remplies = lignes
        .where((l) => l.$2 != null && l.$2!.trim().isNotEmpty)
        .toList();

    if (remplies.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: Tokens.space16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Tokens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titre.toUpperCase(),
                style: theme.labelSmall?.copyWith(
                  color: colors.textMuted,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: Tokens.space8),
              for (final (libelle, valeur) in remplies)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Tokens.space4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          libelle,
                          style: theme.bodySmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(width: Tokens.space8),
                      Expanded(
                        child: Text(
                          valeur!,
                          textAlign: TextAlign.end,
                          style: theme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.texte, this.onRetry});

  final String texte;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              texte,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.textMuted),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: Tokens.space12),
              TextButton(onPressed: onRetry, child: const Text('Réessayer')),
            ],
          ],
        ),
      ),
    );
  }
}

final _jourFormat = DateFormat('dd/MM/yyyy');
final _moisFormat = DateFormat('MMMM yyyy', 'fr');
final _montantFormat = NumberFormat.decimalPattern('fr');

String? _jour(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final date = DateTime.tryParse(iso);

  return date == null ? iso : _jourFormat.format(date);
}

String _periode(String? periode) {
  if (periode == null || periode.isEmpty) return '—';
  final date = DateTime.tryParse('$periode-01');

  return date == null ? periode : _moisFormat.format(date);
}

String? _montant(double? valeur) =>
    valeur == null ? null : '${_montantFormat.format(valeur)} F CFA';
