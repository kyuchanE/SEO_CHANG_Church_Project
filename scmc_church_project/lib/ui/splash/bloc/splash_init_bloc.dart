import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/version_data.dart';
import 'package:scmc_church_project/domain/usecase/main_item_usecase.dart';
import 'package:scmc_church_project/domain/usecase/version_info_usecase.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_event.dart';
import 'package:scmc_church_project/ui/splash/bloc/splash_init_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 스플래시 초기화 Bloc
@injectable
class SplashInitBloc extends Bloc<SplashInitEvent, SplashInitState> {
  final VersionInfoUsecase _versionInfoUsecase;
  final MainItemUsecase _mainItemUsecase;

  SplashInitBloc(
    this._versionInfoUsecase,
    this._mainItemUsecase,
  ) : super(SplashInitState(SplashInitStatus.initial)) {
    /// 초기 버전 및 데이터 조회
    on<InitFetchDataEvent>((event, emit) async {
      emit(SplashInitState(SplashInitStatus.loading));
      await _initFetchData(emit);
      // TODO: 버전 체크 후 메인 아이템 데이터 조회
      await _initMainItemData(emit);
    });
  }

  /// 초기 버전 데이터 조회
  Future<void> _initFetchData(
    Emitter<SplashInitState> emit,
  ) async {
    var result = await _versionInfoUsecase.execute(null);
    result.fold(
      (error) {
        emit(SplashInitState(SplashInitStatus.error));
      },
      (data) {
        SplashInitState(
          SplashInitStatus.loading,
          versionData: data,
        );
      },
    );

    /// Test
    // emit(SplashInitState(
    //   SplashInitStatus.success,
    // ));
  }

  /// 메인 아이템 데이터 조회
  Future<void> _initMainItemData(
    Emitter<SplashInitState> emit,
  ) async {
    var result = await _mainItemUsecase.execute(null);

    result.fold(
      (error) {
        emit(SplashInitState(SplashInitStatus.error));
      },
      (data) {
        emit(SplashInitState(
          SplashInitStatus.success,
          versionData: state.versionData,
          mainItemData: data,
        ));
      },
    );
  }
}
