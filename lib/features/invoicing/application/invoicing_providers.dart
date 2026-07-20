import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_remote_data_source.dart';
import 'package:sytium_mobile/features/invoicing/data/invoicing_repository_impl.dart';
import 'package:sytium_mobile/features/invoicing/domain/invoicing_repository.dart';

part 'invoicing_providers.g.dart';

@riverpod
InvoicingRepository invoicingRepository(Ref ref) =>
    InvoicingRepositoryImpl(InvoicingRemoteDataSource(ref.watch(authDioProvider)));
