import '../../biometrics/domain/health_state_snapshot.dart';
import '../../profile/domain/user_context.dart';

class UserStateSnapshot {
  const UserStateSnapshot({
    required this.biometricsSnapshot,
    required this.userContext,
    required this.stressLevel,
    required this.stressTitle,
    required this.isBiometricsFresh,
  });

  final HealthStateSnapshot? biometricsSnapshot;
  final UserContext? userContext;
  final int stressLevel;
  final String stressTitle;
  final bool isBiometricsFresh;
}
