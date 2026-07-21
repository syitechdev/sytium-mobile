import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Une entrée sélectionnable, telle qu'affichée dans la liste.
@immutable
class PickerEntry<T> {
  const PickerEntry({
    required this.value,
    required this.label,
    this.detail,
  });

  final T value;
  final String label;

  /// Deuxième ligne : téléphone, solde, poste… ce qui départage deux homonymes.
  final String? detail;

  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return label.toLowerCase().contains(q) ||
        (detail?.toLowerCase().contains(q) ?? false);
  }
}

/// Feuille de sélection avec recherche.
///
/// Le filtrage est local, sur une liste déjà chargée : c'est ce que fait le web,
/// et cela garde la recherche instantanée sur un réseau capricieux.
Future<T?> showSearchPicker<T>(
  BuildContext context, {
  required String title,
  required List<PickerEntry<T>> entries,
  String hint = 'Rechercher…',
  String emptyLabel = 'Aucun résultat.',
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _SearchPickerSheet<T>(
      title: title,
      entries: entries,
      hint: hint,
      emptyLabel: emptyLabel,
    ),
  );
}

class _SearchPickerSheet<T> extends StatefulWidget {
  const _SearchPickerSheet({
    required this.title,
    required this.entries,
    required this.hint,
    required this.emptyLabel,
  });

  final String title;
  final List<PickerEntry<T>> entries;
  final String hint;
  final String emptyLabel;

  @override
  State<_SearchPickerSheet<T>> createState() => _SearchPickerSheetState<T>();
}

class _SearchPickerSheetState<T> extends State<_SearchPickerSheet<T>> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final visible = widget.entries
        .where((e) => e.matches(_query.text))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Tokens.space16,
                Tokens.space16,
                Tokens.space8,
                0,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(widget.title, style: theme.titleMedium)),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Fermer',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Tokens.space16,
                Tokens.space8,
                Tokens.space16,
                Tokens.space8,
              ),
              child: TextField(
                controller: _query,
                autofocus: true,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Tokens.space24),
                        child: Text(
                          widget.emptyLabel,
                          textAlign: TextAlign.center,
                          style: theme.bodyMedium?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: visible.length,
                      itemBuilder: (context, i) {
                        final entry = visible[i];
                        return ListTile(
                          title: Text(entry.label),
                          subtitle: entry.detail == null
                              ? null
                              : Text(entry.detail!),
                          onTap: () => Navigator.of(context).pop(entry.value),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
