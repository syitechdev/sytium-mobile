import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.organizationId,
    this.organizationName,
    this.organizationLogoUrl,
    this.organizationPrimaryColor,
    this.organizationAccentColor,
    this.photoUrl,
    this.poste,
    this.departement,
    this.fonction,
    this.roleLabel = 'Utilisateur',
    this.roles = const [],
  });

  final String id;
  final String name;
  final String email;
  final String? organizationId;
  final String? organizationName;

  /// Fully-resolved organization logo URL (null → use the Sytium fallback).
  final String? organizationLogoUrl;

  /// Organization branding hex colors (null → Sytium defaults). `primary`
  /// drives chrome, `accent` drives the brand/CTA color.
  final String? organizationPrimaryColor;
  final String? organizationAccentColor;

  /// Fully-resolved profile photo URL (null → initials avatar).
  final String? photoUrl;

  /// Employee job title from the bootstrap employee profile (null → no HR link).
  final String? poste;
  final String? departement;
  final String? fonction;

  /// French label of the user's primary role (e.g. "Employé").
  final String roleLabel;
  final List<String> roles;
}
