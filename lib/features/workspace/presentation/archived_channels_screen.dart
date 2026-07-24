import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/features/workspace/application/workspace_providers.dart';
import 'package:sytium_mobile/features/workspace/domain/workspace_models.dart';
import 'package:sytium_mobile/features/workspace/presentation/chat_thread_screen.dart';
import 'package:sytium_mobile/shared/widgets/error_state.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Canaux archivés : consultation en lecture, ouverture du fil, et désarchivage.
class ArchivedChannelsScreen extends ConsumerWidget {
  const ArchivedChannelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(archivedChannelsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Canaux archivés')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(archivedChannelsProvider),
        child: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => ListView(
            children: [
              const SizedBox(height: Tokens.space48),
              ErrorState(
                message: 'Chargement impossible.',
                onRetry: () => ref.invalidate(archivedChannelsProvider),
              ),
            ],
          ),
          data: (channels) {
            if (channels.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: Tokens.space48),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(Tokens.space24),
                      child: Text('Aucun canal archivé.'),
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              itemCount: channels.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final c = channels[i];
                return ListTile(
                  leading: const Icon(Icons.tag),
                  title: Text(c.title),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ChatThreadScreen(conversation: c),
                    ),
                  ),
                  trailing: _UnarchiveButton(conversation: c),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _UnarchiveButton extends ConsumerStatefulWidget {
  const _UnarchiveButton({required this.conversation});
  final Conversation conversation;

  @override
  ConsumerState<_UnarchiveButton> createState() => _UnarchiveButtonState();
}

class _UnarchiveButtonState extends ConsumerState<_UnarchiveButton> {
  bool _busy = false;

  Future<void> _unarchive() async {
    if (_busy) return;
    setState(() => _busy = true);
    final result = await ref
        .read(workspaceRepositoryProvider)
        .setChannelArchived(widget.conversation.id, isArchived: false);
    if (!mounted) return;
    setState(() => _busy = false);
    result.fold(
      (_) {
        ref
          ..invalidate(archivedChannelsProvider)
          ..invalidate(conversationsProvider);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Canal désarchivé.')));
      },
      (f) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(f.message ?? 'Action impossible.')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _busy
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : TextButton(onPressed: _unarchive, child: const Text('Désarchiver'));
  }
}
