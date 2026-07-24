import 'package:flutter/material.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Format structuré du web : `@[Nom](uuid)` — uuid = 36 caractères hex/tirets.
/// C'est la SEULE forme que le backend (`syncMentions`) reconnaît pour peupler
/// `workspace_mentions` et déclencher la notification de mention. Le rendu
/// n'affiche que le nom ; l'uuid reste masqué (identique au web).
final RegExp _kStructuredMention = RegExp(
  r'@\[([^\]]+)\]\(([0-9a-fA-F-]{36})\)',
);

/// Repli legacy : `@nom` (lettres/chiffres/`.`/`-`/`_`, accents compris), tel
/// que le web le stylise aussi en badge. Ne matche qu'en début de mot.
final RegExp _kLegacyMention = RegExp(r'@[\p{L}0-9._-]+', unicode: true);

bool _isWordBoundary(String ch) =>
    ch != '@' && !RegExp(r'[\p{L}0-9._-]', unicode: true).hasMatch(ch);

/// Rend le contenu d'un message en stylisant les mentions comme le web : badge
/// nom-seul en couleur IA (indigo). Le reste du texte est rendu tel quel — la
/// portée volontaire ici est la mention, pas un moteur Markdown complet.
class MentionText extends StatelessWidget {
  const MentionText(this.content, {required this.style, super.key});

  final String content;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spans = _buildSpans(
      content,
      mentionColor: colors.ai,
      mentionBg: colors.ai.withValues(alpha: 0.14),
      baseStyle: style,
    );
    return Text.rich(TextSpan(style: style, children: spans));
  }
}

List<InlineSpan> _buildSpans(
  String content, {
  required Color mentionColor,
  required Color mentionBg,
  required TextStyle baseStyle,
}) {
  final spans = <InlineSpan>[];
  final buffer = StringBuffer();

  void flush() {
    if (buffer.isNotEmpty) {
      spans.add(TextSpan(text: buffer.toString()));
      buffer.clear();
    }
  }

  InlineSpan badge(String label) => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.space4),
      decoration: BoxDecoration(
        color: mentionBg,
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
      ),
      child: Text(
        label,
        style: baseStyle.copyWith(
          color: mentionColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  var i = 0;
  while (i < content.length) {
    final structured = _kStructuredMention.matchAsPrefix(content, i);
    if (structured != null) {
      flush();
      spans.add(badge('@${structured.group(1)}'));
      i = structured.end;
      continue;
    }
    if (content[i] == '@' && (i == 0 || _isWordBoundary(content[i - 1]))) {
      final legacy = _kLegacyMention.matchAsPrefix(content, i);
      if (legacy != null && legacy.end - legacy.start > 1) {
        flush();
        spans.add(badge(legacy.group(0)!));
        i = legacy.end;
        continue;
      }
    }
    buffer.write(content[i]);
    i++;
  }
  flush();
  return spans;
}
