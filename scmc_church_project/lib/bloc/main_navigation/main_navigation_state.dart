/// 메인 네비게이션 상태
enum MainNavigationPage {
  mainHome,
  mainSearch,
  mainInfo,
}

/// 메인 네비게이션 페이지
class MainNavigationState {
  final MainNavigationPage page;

  MainNavigationState(this.page);
}
