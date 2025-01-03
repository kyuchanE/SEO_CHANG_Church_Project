import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/domain/usecase/bible_info_usecase.dart';

@injectable
class BibleBloc extends Bloc<BibleEvent, BibleState> {
  final BibleInfoUsecase _bibleInfoUsecase;

  BibleBloc(
    this._bibleInfoUsecase,
  ) : super(BibleState(page: BiblePage.bibleCategory)) {
    on<ChangeBiblePageEvent>(
        (event, emit) => _changeBiblePage(event, emit, state));

    on<ChangeBibleCategoryEvent>(
        (event, emit) => _changeBibleCategoryEvent(event, emit, state));

    on<InitFetchBibleDataEvent>((event, emit) async {
      emit(BibleState(status: BibleStatus.loading));
      await _initFetchBibleData(emit, state);
    });
  }

  /// 성경 페이지 변경
  Future _changeBiblePage(
    ChangeBiblePageEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    emit(BibleState(
      status: state.status,
      page: event.page,
      category: event.category,
      chapter: event.chapter,
      verse: event.verse,
      bibleChapterData: state.bibleChapterData,
    ));
  }

  /// 성경 카테고리 변경
  Future _changeBibleCategoryEvent(
    ChangeBibleCategoryEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    emit(BibleState(
      status: state.status,
      page: BiblePage.bibleCategory,
      category: event.category,
      bibleChapterData: state.bibleChapterData,
    ));
  }

  /// 초기 성경 데이터 조회
  Future<void> _initFetchBibleData(
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    var result = await _bibleInfoUsecase.execute(null);
    result.fold(
      (error) {
        emit(BibleState(
          status: BibleStatus.error,
          page: state.page,
          category: state.category,
          chapter: state.chapter,
          verse: state.verse,
          errorMessage: "성경 데이터 조회 실패",
        ));
      },
      (data) {
        emit(BibleState(
          status: data == null ? BibleStatus.error : BibleStatus.success,
          page: state.page,
          category: state.category,
          chapter: state.chapter,
          verse: state.verse,
          bibleChapterData: data,
          errorMessage: data == null ? "성경 데이터 조회 실패" : null,
        ));
      },
    );
  }
}
