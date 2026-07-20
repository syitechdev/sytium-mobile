import 'package:sytium_mobile/core/result/result.dart';
import 'package:sytium_mobile/features/devices/domain/device_session.dart';

abstract interface class SessionsRepository {
  /// Sessions mobiles ouvertes pour l'utilisateur connecté.
  Future<Result<List<DeviceSession>>> list();

  /// Révoque la session d'un autre appareil. Le serveur refuse la session
  /// courante : la terminer relève de la déconnexion.
  Future<Result<void>> revoke(String id);
}
