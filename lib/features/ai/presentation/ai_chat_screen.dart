import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sytium_mobile/features/ai/application/ai_providers.dart';
import 'package:sytium_mobile/features/ai/domain/ai_models.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Contexte passé à l'assistant (module courant, locale, devise).
const _kAiContext = {'module': 'Messagerie', 'locale': 'fr', 'currency': 'XOF'};

/// Écran de conversation avec l'assistant Sytium AI : historique, envoi et
/// réponse en **streaming** (la bulle assistant se remplit en direct), accent
/// indigo réservé à l'IA. Rendu Markdown des réponses.
class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({this.conversationId, super.key});

  final String? conversationId;

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _composer = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(aiChatProvider.notifier).init(widget.conversationId),
    );
  }

  @override
  void dispose() {
    _composer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  void _send() {
    final text = _composer.text.trim();
    if (text.isEmpty) return;
    _composer.clear();
    ref.read(aiChatProvider.notifier).send(text, context: _kAiContext);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = ref.watch(aiChatProvider);

    // Suivre le bas à chaque nouvel état (nouveau message ou delta de streaming).
    ref.listen(aiChatProvider, (_, __) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: colors.ai,
              child: const Icon(Icons.smart_toy, size: 18, color: Colors.white),
            ),
            const SizedBox(width: Tokens.space8),
            const Text('Sytium IA'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Nouvelle conversation',
            icon: const Icon(Icons.add_comment_outlined),
            onPressed: () {
              ref.read(aiChatProvider.notifier).reset();
              _composer.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.loading
                ? const Center(child: CircularProgressIndicator())
                : state.messages.isEmpty
                ? const _AiWelcome()
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(
                      vertical: Tokens.space12,
                    ),
                    itemCount: state.messages.length,
                    itemBuilder: (context, i) {
                      final m = state.messages[i];
                      final isLast = i == state.messages.length - 1;
                      return _AiBubble(
                        message: m,
                        // Bulle assistant vide en cours de stream → « … ».
                        typing:
                            state.streaming &&
                            isLast &&
                            m.role == AiRole.assistant &&
                            m.content.isEmpty,
                      );
                    },
                  ),
          ),
          if (state.error != null) _AiError(message: state.error!),
          _AiComposer(
            controller: _composer,
            streaming: state.streaming,
            onSend: _send,
            onStop: () => ref.read(aiChatProvider.notifier).stop(),
          ),
        ],
      ),
    );
  }
}

class _AiWelcome extends StatelessWidget {
  const _AiWelcome();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.smart_toy_outlined, size: 48, color: colors.ai),
            const SizedBox(height: Tokens.space12),
            Text(
              'Posez une question à Sytium IA',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Tokens.space4),
            Text(
              'Résumés, rédaction, questions sur vos données…',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiBubble extends StatelessWidget {
  const _AiBubble({required this.message, required this.typing});
  final AiMessage message;
  final bool typing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isUser = message.isUser;
    final bg = isUser ? colors.ai : colors.card;
    final fg = isUser ? Colors.white : colors.textPrimary;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space12,
        vertical: Tokens.space4,
      ),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.82,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Tokens.space12,
                vertical: Tokens.space8,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
                border: isUser ? null : Border.all(color: colors.border),
              ),
              child: typing
                  ? Text(
                      '…',
                      style: TextStyle(color: colors.textMuted, fontSize: 20),
                    )
                  : (isUser
                        ? Text(message.content, style: TextStyle(color: fg))
                        : GptMarkdown(
                            message.content,
                            style: TextStyle(color: fg),
                          )),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiError extends StatelessWidget {
  const _AiError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      color: colors.danger.withValues(alpha: 0.10),
      padding: const EdgeInsets.symmetric(
        horizontal: Tokens.space16,
        vertical: Tokens.space8,
      ),
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: colors.danger),
      ),
    );
  }
}

class _AiComposer extends StatelessWidget {
  const _AiComposer({
    required this.controller,
    required this.streaming,
    required this.onSend,
    required this.onStop,
  });

  final TextEditingController controller;
  final bool streaming;
  final VoidCallback onSend;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Tokens.space8,
          vertical: Tokens.space8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText: 'Message à Sytium IA',
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: Tokens.space8),
            if (streaming)
              IconButton(
                icon: const Icon(Icons.stop_circle),
                color: colors.danger,
                tooltip: 'Arrêter',
                onPressed: onStop,
              )
            else
              IconButton(
                icon: const Icon(Icons.send),
                color: colors.ai,
                tooltip: 'Envoyer',
                onPressed: onSend,
              ),
          ],
        ),
      ),
    );
  }
}
