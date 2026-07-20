import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_controller.dart';
import 'package:sytium_mobile/theme/branding.dart';

part 'branding_provider.g.dart';

/// Resolves the active [Branding] from the authenticated organization's
/// colors. Falls back to the Sytium identity before login or when the org
/// defines no colors. Recomputes whenever the auth session changes.
@Riverpod(keepAlive: true)
Branding branding(Ref ref) {
  final auth = ref.watch(authControllerProvider).valueOrNull;
  if (auth is Authenticated) {
    final user = auth.session.user;
    return Branding.fromHex(
      accent: user.organizationAccentColor,
      primary: user.organizationPrimaryColor,
    );
  }
  return Branding.sytium();
}
