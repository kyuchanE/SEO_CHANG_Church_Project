import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/usecase/version_info_usecase.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_event.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 스플래시 초기화 Bloc
@injectable
class SplashInitBloc extends Bloc<SplashInitEvent, SplashInitState> {
  final VersionInfoUsecase _versionInfoUsecase;

  SplashInitBloc(this._versionInfoUsecase)
      : super(SplashInitState(SplashInitStatus.initial, null)) {
    on<InitFetchDataEvent>((event, emit) async {
      emit(SplashInitState(SplashInitStatus.loading, null));
      await _initFetchData(emit);
    });
  }

  /// 초기 버전 데이터 조회
  Future<void> _initFetchData(
    Emitter<SplashInitState> emit,
  ) async {
    var result = await _versionInfoUsecase.execute(null);
    result.fold(
      (error) {
        emit(SplashInitState(SplashInitStatus.error, null));
      },
      (data) {
        emit(SplashInitState(SplashInitStatus.success, data));
      },
    );
  }
}