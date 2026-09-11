import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/subscription/data/subscription_remote_data_source.dart';
import 'package:sytium_mobile/features/subscription/data/subscription_repository_impl.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_models.dart';
import 'package:sytium_mobile/features/subscription/domain/subscription_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'subscription_providers.g.dart';

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) =>
    SubscriptionRepositoryImpl(
      SubscriptionRemoteDataSource(ref.watch(authDioProvider)),
    );

@riverpod
Future<SubscriptionSummary> subscriptionOverview(Ref ref) async {
  final result = await ref.watch(subscriptionRepositoryProvider).overview();
  return result.fold((s) => s, (f) => throw Exception(f.message ?? 'Erreur'));
}

@riverpod
Future<List<SubscriptionInvoice>> subscriptionInvoices(Ref ref) async {
  final result = await ref.watch(subscriptionRepositoryProvider).invoices();
  return result.fold((l) => l, (f) => throw Exception(f.message ?? 'Erreur'));
}

/// Ouvre une adresse hors de l'application (page de paiement). Injectable pour
/// que les tests verifient l'ouverture sans lancer de navigateur.
typedef UrlOpener = Future<bool> Function(Uri uri);

@riverpod
UrlOpener urlOpener(Ref ref) =>
    (uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

/// Moyens de paiement de l'organisation.
///
/// OPTIMISTE, comme les preferences de notification : le moyen choisi passe
/// « par defaut » a l'instant du toucher. En cas d'echec, la selection revient
/// et l'echec est rendu a l'ecran pour qu'il le dise.
@riverpod
class PaymentMethodsController extends _$PaymentMethodsController {
  @override
  Future<List<OrgPaymentMethod>> build() async {
    final result = await ref
        .watch(subscriptionRepositoryProvider)
        .paymentMethods();
    return result.fold((l) => l, (f) => throw Exception(f.message ?? 'Erreur'));
  }

  /// `null` si enregistre, l'echec sinon.
  Future<Failure?> setDefault(String id) async {
    final avant = state.asData?.value;
    if (avant == null) return null;

    state = AsyncData([
      for (final m in avant) m.withDefault(value: m.id == id),
    ]);

    final result = await ref
        .read(subscriptionRepositoryProvider)
        .setDefaultPaymentMethod(id);

    return result.fold((_) => null, (f) {
      state = AsyncData(avant);
      return f;
    });
  }
}
