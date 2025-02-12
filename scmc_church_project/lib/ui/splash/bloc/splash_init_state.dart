import 'package:scmc_church_project/domain/models/main_item_data.dart';
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
  final MainItemData? mainItemData;
  final String? errorMessage;

  SplashInitState(
    this.status, {
    this.versionData,
    this.mainItemData,
    this.errorMessage,
  });
}
