import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/calls/data/calls_remote_data_source.dart';
import 'package:sytium_mobile/features/calls/data/calls_repository_impl.dart';
import 'package:sytium_mobile/features/calls/domain/calls_repository.dart';

part 'calls_providers.g.dart';

@Riverpod(keepAlive: true)
CallsRepository callsRepository(Ref ref) =>
    CallsRepositoryImpl(CallsRemoteDataSource(ref.watch(authDioProvider)));
