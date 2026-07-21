import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/documents/application/documents_providers.dart';
import 'package:sytium_mobile/features/documents/domain/document_models.dart';
import 'package:sytium_mobile/features/documents/presentation/widgets/doc_tile.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// « Compta & docs » tab: filterable feed of factures / proformas / documents.
class ComptaDocsView extends ConsumerStatefulWidget {
  const ComptaDocsView({super.key});

  @override
  ConsumerState<ComptaDocsView> createState() => _ComptaDocsViewState();
}

class _ComptaDocsViewState extends ConsumerState<ComptaDocsView> {
  DocType? _filter;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(documentsProvider(_filter));
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(
            Tokens.space16,
            Tokens.space16,
            Tokens.space16,
            Tokens.space8,
          ),
          child: Row(
            children: [
              _Chip(
                label: 'Tous',
                selected: _filter == null,
                onTap: () => setState(() => _filter = null),
              ),
              for (final t in const [DocType.facture, DocType.proforma, DocType.document])
                Padding(
                  padding: const EdgeInsets.only(left: Tokens.space8),
                  child: _Chip(
                    label: t.label,
                    selected: _filter == t,
                    onTap: () => setState(() => _filter = t),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => ref.invalidate(documentsProvider(_filter)),
            child: async.when(
              loading: () => const _Skeleton(),
              error: (e, _) => ListView(
                children: [
                  const SizedBox(height: Tokens.space48),
                  ErrorState(
                    message: 'Impossible de charger les documents.',
                    onRetry: () => ref.invalidate(documentsProvider(_filter)),
                  ),
                ],
              ),
              data: (docs) => docs.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: Tokens.space48),
                        Center(child: Text('Aucun document.')),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        Tokens.space16,
                        0,
                        Tokens.space16,
                        Tokens.space16,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, i) => DocTile(doc: docs[i]),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.border.withValues(alpha: 0.55);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space16),
      children: [
        for (var i = 0; i < 8; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: Tokens.space8),
            child: SizedBox(
              height: 64,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(Tokens.radiusMd),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
