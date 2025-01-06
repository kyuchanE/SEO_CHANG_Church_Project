import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
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
        (event, emit) => _changeBiblePage(event, emit, state.copyWith()));

    on<ChangeBibleAbbrevEvent>((event, emit) =>
        _changeBibleAbbrevEvent(event, emit, state.copyWith()));

    on<InitFetchBibleDataEvent>((event, emit) async {
      emit(BibleState(status: BibleStatus.loading));
      await _initFetchBibleData(emit, state.copyWith());
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
      abbrev: event.abbrev,
      chapter: event.chapter,
      verse: event.verse,
      newTestamentList: state.newTestamentList,
      oldTestamentList: state.oldTestamentList,
      allTestamentList: state.allTestamentList,
    ));
  }

  /// 성경 카테고리 변경
  Future _changeBibleAbbrevEvent(
    ChangeBibleAbbrevEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    emit(BibleState(
      status: state.status,
      page: event.page,
      abbrev: event.abbrev,
      newTestamentList: state.newTestamentList,
      oldTestamentList: state.oldTestamentList,
      allTestamentList: state.allTestamentList,
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
          abbrev: state.abbrev,
          chapter: state.chapter,
          verse: state.verse,
          errorMessage: "성경 데이터 조회 실패",
        ));
      },
      (data) {
        List<BibleChapterData> newTestamentList = [];
        List<BibleChapterData> oldTestamentList = [];
        for (var element in data!) {
          if (element.isOldTestament) {
            oldTestamentList.add(element);
          } else {
            newTestamentList.add(element);
          }
        }
        emit(BibleState(
          status: data == null ? BibleStatus.error : BibleStatus.success,
          page: state.page,
          abbrev: state.abbrev,
          chapter: state.chapter,
          verse: state.verse,
          newTestamentList: newTestamentList,
          oldTestamentList: oldTestamentList,
          allTestamentList: data,
          errorMessage: data == null ? "성경 데이터 조회 실패" : null,
        ));
      },
    );
  }
}
