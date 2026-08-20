import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sytium_mobile/features/auth/application/auth_providers.dart';
import 'package:sytium_mobile/features/employee_space/data/dtos/employee_space_dtos.dart';
import 'package:sytium_mobile/features/employee_space/data/employee_space_remote_data_source.dart';

part 'employee_space_providers.g.dart';

@riverpod
EmployeeSpaceRemoteDataSource employeeSpaceSource(Ref ref) =>
    EmployeeSpaceRemoteDataSource(ref.watch(authDioProvider));

/// Fiche du salarié connecté. `keepAlive` : elle ne change pas d'une minute à
/// l'autre, et l'écran se rouvre souvent.
@Riverpod(keepAlive: true)
Future<EmployeeProfileDto?> myProfile(Ref ref) =>
    ref.watch(employeeSpaceSourceProvider).profile();

@riverpod
Future<List<MyPayslipDto>> myPayslips(Ref ref) =>
    ref.watch(employeeSpaceSourceProvider).payslips();

@riverpod
Future<List<MyDocumentDto>> myDocuments(Ref ref) =>
    ref.watch(employeeSpaceSourceProvider).documents();

@riverpod
Future<InternalRegulationDto?> myInternalRegulation(Ref ref) =>
    ref.watch(employeeSpaceSourceProvider).internalRegulation();
