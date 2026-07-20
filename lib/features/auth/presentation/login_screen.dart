import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/shared/widgets/app_primary_button.dart';
import 'package:sytium_mobile/shared/widgets/app_text_field.dart';
import 'package:sytium_mobile/shared/widgets/legal_footer.dart';
import 'package:sytium_mobile/shared/widgets/theme_toggle_button.dart';
import 'package:sytium_mobile/theme/sytium_colors.dart';
import 'package:sytium_mobile/theme/tokens.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _submitting = false;
  String? _emailError;
  String? _bannerError;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitting = true;
      _emailError = null;
      _bannerError = null;
    });

    final failure = await ref
        .read(authControllerProvider.notifier)
        .login(email: _email.text.trim(), password: _password.text);

    if (!mounted) return;
    setState(() => _submitting = false);

    if (failure == null) {
      unawaited(HapticFeedback.lightImpact());
      return; // router redirects on Authenticated
    }
    _applyFailure(failure);
  }

  void _applyFailure(Failure failure) {
    switch (failure) {
      case ValidationFailure(:final fieldErrors):
        setState(() {
          _emailError =
              fieldErrors['email']?.first ?? 'Email ou mot de passe incorrect';
        });
      case UnauthorizedFailure():
        setState(() => _emailError = 'Email ou mot de passe incorrect');
      default:
        setState(
          () => _bannerError =
              failure.message ?? 'Une erreur est survenue. Réessayez.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Tokens.space24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Tokens.maxContentWidth,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(colors.logo, height: 64),
                      const SizedBox(height: Tokens.space12),
                      Text(
                        'Plateforme ERP Sytium',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: Tokens.space32),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(Tokens.space24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Connexion',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: Tokens.space8),
                              Text(
                                'Application réservée au personnel autorisé',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: colors.textMuted),
                              ),
                              const SizedBox(height: Tokens.space24),
                              if (_bannerError != null) ...[
                                _Banner(message: _bannerError!),
                                const SizedBox(height: Tokens.space16),
                              ],
                              AppTextField(
                                controller: _email,
                                label: 'Email',
                                hint: 'vous@entreprise.com',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                prefixIcon: Icons.mail_outline,
                                errorText: _emailError,
                              ),
                              const SizedBox(height: Tokens.space16),
                              AppTextField(
                                controller: _password,
                                label: 'Mot de passe',
                                obscure: _obscure,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _submit(),
                                prefixIcon: Icons.lock_outline,
                                suffix: IconButton(
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  tooltip: _obscure
                                      ? 'Afficher le mot de passe'
                                      : 'Masquer le mot de passe',
                                ),
                              ),
                              const SizedBox(height: Tokens.space24),
                              AppPrimaryButton(
                                label: 'Se connecter',
                                isLoading: _submitting,
                                onPressed: _submit,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Tokens.space24),
                      const LegalFooter(),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: Tokens.space8,
              right: Tokens.space8,
              child: ThemeToggleButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(Tokens.space12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Tokens.radiusSm),
        border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.danger, size: 20),
          const SizedBox(width: Tokens.space8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
