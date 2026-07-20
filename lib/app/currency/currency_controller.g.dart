// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currencyControllerHash() =>
    r'822e8644ca8c6ac11323cd91d811c96c037baee6';

/// Holds the user's display currency (XOF/EUR/USD), persisted across launches.
/// App watches this and mirrors it into `Money.current`. Default: XOF (FCFA).
///
/// Copied from [CurrencyController].
@ProviderFor(CurrencyController)
final currencyControllerProvider =
    NotifierProvider<CurrencyController, AppCurrency>.internal(
      CurrencyController.new,
      name: r'currencyControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currencyControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrencyController = Notifier<AppCurrency>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
