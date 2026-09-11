// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subscriptionRepositoryHash() =>
    r'75273062eb339103f643e3b161b0aecad0771295';

/// See also [subscriptionRepository].
@ProviderFor(subscriptionRepository)
final subscriptionRepositoryProvider =
    AutoDisposeProvider<SubscriptionRepository>.internal(
      subscriptionRepository,
      name: r'subscriptionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionRepositoryRef =
    AutoDisposeProviderRef<SubscriptionRepository>;
String _$subscriptionOverviewHash() =>
    r'cd2384f77ccf035d0c35746d0a8a62bdf3fbd56a';

/// See also [subscriptionOverview].
@ProviderFor(subscriptionOverview)
final subscriptionOverviewProvider =
    AutoDisposeFutureProvider<SubscriptionSummary>.internal(
      subscriptionOverview,
      name: r'subscriptionOverviewProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionOverviewHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionOverviewRef =
    AutoDisposeFutureProviderRef<SubscriptionSummary>;
String _$subscriptionInvoicesHash() =>
    r'9291d2d78b091e5b28bb0d58b299517f60ad872c';

/// See also [subscriptionInvoices].
@ProviderFor(subscriptionInvoices)
final subscriptionInvoicesProvider =
    AutoDisposeFutureProvider<List<SubscriptionInvoice>>.internal(
      subscriptionInvoices,
      name: r'subscriptionInvoicesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionInvoicesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionInvoicesRef =
    AutoDisposeFutureProviderRef<List<SubscriptionInvoice>>;
String _$urlOpenerHash() => r'e2a6b568ed7a316e1e07701c7fe366f0776d5aec';

/// See also [urlOpener].
@ProviderFor(urlOpener)
final urlOpenerProvider = AutoDisposeProvider<UrlOpener>.internal(
  urlOpener,
  name: r'urlOpenerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$urlOpenerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UrlOpenerRef = AutoDisposeProviderRef<UrlOpener>;
String _$paymentMethodsControllerHash() =>
    r'8fc9d80961825d48979c5374024b87f6964ad73e';

/// Moyens de paiement de l'organisation.
///
/// OPTIMISTE, comme les preferences de notification : le moyen choisi passe
/// « par defaut » a l'instant du toucher. En cas d'echec, la selection revient
/// et l'echec est rendu a l'ecran pour qu'il le dise.
///
/// Copied from [PaymentMethodsController].
@ProviderFor(PaymentMethodsController)
final paymentMethodsControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      PaymentMethodsController,
      List<OrgPaymentMethod>
    >.internal(
      PaymentMethodsController.new,
      name: r'paymentMethodsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$paymentMethodsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PaymentMethodsController =
    AutoDisposeAsyncNotifier<List<OrgPaymentMethod>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
