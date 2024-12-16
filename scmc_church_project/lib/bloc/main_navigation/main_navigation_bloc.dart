import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scmc_church_project/bloc/main_navigation/main_navigation_event.dart';
import 'package:scmc_church_project/bloc/main_navigation/main_navigation_state.dart';

/// 메인 하단 네비게이션 Bloc
class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc()
      : super(MainNavigationState(MainNavigationPage.mainHome)) {
    on<MainBottomNavClickEvent>((event, emit) {
      emit(MainNavigationState(event.page));
    });
  }
}
