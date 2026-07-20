import 'package:flutter/foundation.dart';
import 'package:sytium_mobile/features/auth/domain/mobile_module.dart';

@immutable
class MobileCapabilities {
  const MobileCapabilities({
    required this.dashboard,
    required this.employeeSpace,
    required this.messaging,
    required this.weeklyObjectives,
    required this.leaveRequests,
    required this.permissionRequests,
    required this.approvals,
    required this.commercial,
    required this.finance,
    this.financeWrite = false,
    this.modules = const [],
  });

  const MobileCapabilities.baseline()
    : dashboard = false,
      employeeSpace = true,
      messaging = true,
      weeklyObjectives = false,
      leaveRequests = false,
      permissionRequests = false,
      approvals = false,
      commercial = false,
      finance = false,
      financeWrite = false,
      modules = const [];

  final bool dashboard;
  final bool employeeSpace;
  final bool messaging;
  final bool weeklyObjectives;
  final bool leaveRequests;
  final bool permissionRequests;
  final bool approvals;
  final bool commercial;
  final bool finance;

  /// True when the user may record cash movements / create invoices from mobile
  /// (SuperAdmin/Admin/Finance). The backend authorizer enforces it regardless.
  final bool financeWrite;

  /// Data-driven Explorer grid entries from the bootstrap.
  final List<MobileModule> modules;
}
