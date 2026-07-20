import 'package:dio/dio.dart';
import 'package:sytium_mobile/core/error/failure.dart';
import 'package:sytium_mobile/core/network/error_mapper.dart';
import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/cash/data/cash_remote_data_source.dart';
import 'package:sytium_mobile/features/cash/domain/cash_models.dart';
import 'package:sytium_mobile/features/cash/domain/cash_repository.dart';

class CashRepositoryImpl implements CashRepository {
  CashRepositoryImpl(this._remote);
  final CashRemoteDataSource _remote;

  @override
  Future<Result<List<CashAccount>>> accounts() => _guard(() async {
        final dtos = await _remote.accounts();
        return dtos
            .map((d) => CashAccount(
                  id: d.id,
                  nom: d.nom,
                  type: d.type,
                  solde: d.solde,
                  devise: d.devise,
                ))
            .toList();
      });

  @override
  Future<Result<CashJournal>> journal() => _guard(() async {
        final dto = await _remote.journal();
        final accounts = await _remote.accounts();
        return CashJournal(
          encaissementsMois: dto.summary.encaissementsMois,
          decaissementsMois: dto.summary.decaissementsMois,
          soldeGlobal: dto.summary.soldeGlobal,
          movements: dto.movements
              .map((m) => CashMovement(
                    id: m.id,
                    type: CashMovementType.fromWire(m.type),
                    montant: m.montant,
                    accountNom: m.accountNom,
                    libelle: m.libelle,
                    date: m.dateMouvement == null
                        ? null
                        : DateTime.tryParse(m.dateMouvement!),
                  ))
              .toList(),
          accounts: accounts
              .map((d) => CashAccount(
                    id: d.id,
                    nom: d.nom,
                    type: d.type,
                    solde: d.solde,
                    devise: d.devise,
                  ))
              .toList(),
        );
      });

  @override
  Future<Result<CashMovementResult>> createMovement(CashMovementInput input) =>
      _guard(() async {
        final dto = await _remote.createMovement(input);
        return CashMovementResult(
          accountId: dto.accountId,
          accountSolde: dto.accountSolde,
        );
      });

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Ok(await run());
    } on DioException catch (e) {
      return Err(mapDioError(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }
}
