import 'package:scmc_church_project/bloc/main_navigation/main_navigation_state.dart';

abstract class MainNavigationEvent {}

/// 메인 하단 네비게이션 클릭 이벤트
class MainBottomNavClickEvent extends MainNavigationEvent {
  final MainNavigationPage page;

  MainBottomNavClickEvent(this.page);
}
