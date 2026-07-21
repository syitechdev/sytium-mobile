import 'dart:async';

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
/// Deux modes, selon la taille du référentiel :
/// - [entries] seul : filtrage local sur une liste déjà chargée, instantané ;
/// - [onSearch] : interrogation du serveur à la frappe, pour les référentiels
///   qu'on ne peut pas tenir en mémoire sans en tronquer la fin.
Future<T?> showSearchPicker<T>(
  BuildContext context, {
  required String title,
  List<PickerEntry<T>> entries = const [],
  Future<List<PickerEntry<T>>> Function(String query)? onSearch,
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
      onSearch: onSearch,
      hint: hint,
      emptyLabel: emptyLabel,
    ),
  );
}

class _SearchPickerSheet<T> extends StatefulWidget {
  const _SearchPickerSheet({
    required this.title,
    required this.entries,
    required this.onSearch,
    required this.hint,
    required this.emptyLabel,
  });

  final String title;
  final List<PickerEntry<T>> entries;
  final Future<List<PickerEntry<T>>> Function(String query)? onSearch;
  final String hint;
  final String emptyLabel;

  @override
  State<_SearchPickerSheet<T>> createState() => _SearchPickerSheetState<T>();
}

class _SearchPickerSheetState<T> extends State<_SearchPickerSheet<T>> {
  final _query = TextEditingController();

  late List<PickerEntry<T>> _remote = widget.entries;
  Timer? _debounce;
  bool _searching = false;

  /// Numéro de la requête en cours : une réponse tardive d'une frappe
  /// précédente ne doit pas écraser un résultat plus récent.
  int _searchToken = 0;

  @override
  void initState() {
    super.initState();
    if (widget.onSearch != null) _search('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    if (widget.onSearch == null) {
      setState(() {});
      return;
    }
    // Une requête par frappe saturerait le réseau ; on attend une pause.
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => _search(value));
  }

  Future<void> _search(String query) async {
    final token = ++_searchToken;
    setState(() => _searching = true);

    final results = await widget.onSearch!(query);
    if (!mounted || token != _searchToken) return;

    setState(() {
      _remote = results;
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final theme = Theme.of(context).textTheme;
    final visible = widget.onSearch != null
        ? _remote
        : widget.entries.where((e) => e.matches(_query.text)).toList();

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
                onChanged: _onQueryChanged,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const Divider(height: 1),
            if (_searching) const LinearProgressIndicator(minHeight: 2),
            Expanded(
              child: visible.isEmpty && !_searching
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
