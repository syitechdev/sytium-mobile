import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/core/upload/upload_repository.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';

part 'upload_providers.g.dart';

@riverpod
UploadRepository uploadRepository(Ref ref) =>
    UploadRepository(ref.watch(authDioProvider));
