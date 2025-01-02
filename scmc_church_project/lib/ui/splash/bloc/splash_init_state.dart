import 'package:scmc_church_project/domain/models/version_data.dart';

/// 초기 앱 진입 통신 상태
enum SplashInitStatus {
  initial,
  loading,
  success,
  error,
}

class SplashInitState {
  final SplashInitStatus status;
  final VersionData? versionData;

  SplashInitState(this.status, this.versionData);
}
