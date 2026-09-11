import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/account/data/account_repository_impl.dart';
import 'package:sytium_mobile/features/account/domain/account_repository.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';

part 'account_providers.g.dart';

@riverpod
AccountRepository accountRepository(Ref ref) =>
    AccountRepositoryImpl(ref.watch(authDioProvider));
