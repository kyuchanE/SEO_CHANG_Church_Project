/// 초기 앱 진입 통신 상태
enum SplashInitStatus {
  initial,
  loading,
  success,
  error,
}

class SplashInitState {
  final SplashInitStatus status;
  final String? strData;

  SplashInitState(this.status, this.strData);
}
