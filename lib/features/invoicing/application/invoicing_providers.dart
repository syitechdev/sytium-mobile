import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/invoicing/data/catalogue_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_repository_impl.dart';
import 'package:sytium_mobile/features/invoicing/domain/catalogue.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_repository.dart';

part 'invoicing_providers.g.dart';

@riverpod
InvoicingRepository invoicingRepository(Ref ref) =>
    InvoicingRepositoryImpl(InvoicingRemoteDataSource(ref.watch(authDioProvider)));

@riverpod
CatalogueRemoteDataSource catalogue(Ref ref) =>
    CatalogueRemoteDataSource(ref.watch(authDioProvider));

/// Catalogue actif, gardé le temps de la saisie : plusieurs lignes le
/// consultent, une seule requête suffit.
@riverpod
Future<List<ProductRef>> products(Ref ref) =>
    ref.watch(catalogueProvider).products();
