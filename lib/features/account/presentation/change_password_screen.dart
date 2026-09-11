import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/account/application/account_providers.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

/// Longueur minimale, celle de `Password::defaults()` cote serveur. Verifiee
/// ici pour repondre tout de suite ; le serveur reste l'arbitre.
const kMinPasswordLength = 8;

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _current = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  String? _currentError;
  String? _passwordError;
  String? _confirmationError;
  bool _saving = false;

  @override
  void dispose() {
    _current.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  bool _validate() {
    setState(() {
      _currentError = _current.text.isEmpty
          ? 'Saisissez votre mot de passe actuel.'
          : null;
      _passwordError = _password.text.length < kMinPasswordLength
          ? 'Au moins $kMinPasswordLength caractères.'
          : null;
      _confirmationError = _confirmation.text != _password.text
          ? 'Les deux mots de passe ne correspondent pas.'
          : null;
    });
    return _currentError == null &&
        _passwordError == null &&
        _confirmationError == null;
  }

  Future<void> _submit() async {
    if (!_validate()) return;

    setState(() => _saving = true);
    final result = await ref
        .read(accountRepositoryProvider)
        .changePassword(
          current: _current.text,
          password: _password.text,
          confirmation: _confirmation.text,
        );
    if (!mounted) return;
    setState(() => _saving = false);

    result.fold(
      (_) {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: context.colors.success,
            content: const Text('Mot de passe modifié.'),
          ),
        );
        Navigator.of(context).pop();
      },
      (f) {
        if (f is ValidationFailure) {
          // Les erreurs du serveur s'affichent sous LEUR champ : « mot de
          // passe actuel incorrect » ne doit pas se lire comme une erreur sur
          // le nouveau.
          setState(() {
            _currentError = f.fieldErrors['current_password']?.first;
            _passwordError = f.fieldErrors['password']?.first;
          });
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: context.colors.danger,
            content: Text(f.message ?? 'Modification impossible. Réessayez.'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(title: const Text('Mot de passe')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Tokens.space16),
          children: [
            // Consequence que le serveur applique et que l'utilisateur doit
            // connaitre AVANT de valider : ses autres appareils se deconnectent.
            Container(
              padding: const EdgeInsets.all(Tokens.space12),
              decoration: BoxDecoration(
                color: colors.card,
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(Tokens.radiusMd),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: Tokens.space16,
                    color: colors.info,
                  ),
                  const SizedBox(width: Tokens.space8),
                  Expanded(
                    child: Text(
                      'Pour votre sécurité, vos autres appareils seront '
                      'déconnectés. Celui-ci reste connecté.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Tokens.space24),
            AppTextField(
              controller: _current,
              label: 'Mot de passe actuel',
              obscure: true,
              errorText: _currentError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _password,
              label: 'Nouveau mot de passe',
              hint: 'Au moins $kMinPasswordLength caractères',
              obscure: true,
              errorText: _passwordError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: Tokens.space16),
            AppTextField(
              controller: _confirmation,
              label: 'Confirmer le nouveau mot de passe',
              obscure: true,
              errorText: _confirmationError,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: Tokens.space24),
            AppPrimaryButton(
              label: 'Modifier le mot de passe',
              isLoading: _saving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
