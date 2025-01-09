import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_event.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/domain/usecase/bible_info_usecase.dart';
import 'package:scmc_church_project/ui/bible/models/bible_item_data.dart';

@injectable
class BibleBloc extends Bloc<BibleEvent, BibleState> {
  final BibleInfoUsecase _bibleInfoUsecase;

  BibleBloc(
    this._bibleInfoUsecase,
  ) : super(BibleState(page: BiblePage.bibleCategory)) {
    // TODO: 사용 안하는 이벤트 제거할까?
    on<ChangeBiblePageEvent>((event, emit) async {
      await _changeBiblePage(event, emit, state.copyWith());
    });

    /// 성경 구약/신약 선택 이벤트
    on<ChangeBibleAbbrevEvent>((event, emit) async {
      await _changeBibleAbbrevEvent(event, emit, state.copyWith());
      event.completer.complete();
    });

    /// 성경 구절 선택 이벤트 (장:절)
    on<ChangeBibleVerseEvent>((event, emit) async {
      await _changeBibleVerseEvent(event, emit, state.copyWith());
      event.completer.complete();
    });

    /// 성경 json 데이터 조회 이벤트
    on<InitFetchBibleDataEvent>((event, emit) async {
      emit(BibleState(status: BibleStatus.loading));
      await _initFetchBibleData(emit, state.copyWith());
    });

    /// 성경 결과 페이지 하단 이전 버튼 이벤트
    on<PreviousBiblePageEvent>((event, emit) async {
      await _previousBibleVerseEvent(event, emit, state.copyWith());
      event.completer.complete();
    });

    /// 성경 결과 페이지 하단 다음 버튼 이벤트
    on<NextBiblePageEvent>((event, emit) async {
      await _nextBibleVerseEvent(event, emit, state.copyWith());
      event.completer.complete();
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
      isFirstBiblePage: false,
      isLastBiblePage: false,
    ));
  }

  /// 성경 카테고리 변경
  Future _changeBibleAbbrevEvent(
    ChangeBibleAbbrevEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    emit(
      BibleState(
        status: state.status,
        page: state.page,
        abbrev: event.abbrev,
        verse: state.verse,
        newTestamentList: state.newTestamentList,
        oldTestamentList: state.oldTestamentList,
        allTestamentList: state.allTestamentList,
        isFirstBiblePage: false,
        isLastBiblePage: false,
      ),
    );
  }

  /// 성경 구절 장 변경
  Future _changeBibleVerseEvent(
    ChangeBibleVerseEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    emit(
      BibleState(
        status: state.status,
        page: state.page,
        abbrev: state.abbrev,
        chapter: state.chapter,
        verse: event.verse,
        newTestamentList: state.newTestamentList,
        oldTestamentList: state.oldTestamentList,
        allTestamentList: state.allTestamentList,
        isFirstBiblePage: _isFirstPage(
              state: state,
              verse: event.verse,
            ) ??
            false,
        isLastBiblePage: _isLastBiblePage(
              state: state,
              verse: event.verse,
            ) ??
            false,
      ),
    );
  }

  /// 이전 성경 구절 조회
  Future _previousBibleVerseEvent(
    PreviousBiblePageEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    final BibleItemData? previousBibleVerse = _getPreviousBibleVerse(
      nowStateVerse: state.verse ?? "0:0",
      bibleItemList: state.allTestamentList ?? [],
      abbrev: state.abbrev ?? "",
    );

    if (previousBibleVerse != null) {
      emit(
        BibleState(
          status: state.status,
          page: state.page,
          abbrev: previousBibleVerse.abbrev,
          verse: previousBibleVerse.verse,
          newTestamentList: state.newTestamentList,
          oldTestamentList: state.oldTestamentList,
          allTestamentList: state.allTestamentList,
          isFirstBiblePage: previousBibleVerse.isFirstBiblePage,
          isLastBiblePage: previousBibleVerse.isLastBiblePage,
        ),
      );
    }
  }

  /// 다음 성경 구절 조회
  Future _nextBibleVerseEvent(
    NextBiblePageEvent event,
    Emitter<BibleState> emit,
    BibleState state,
  ) async {
    final BibleItemData? nextBibleVerse = _getNextBibleItem(
      nowStateVerse: state.verse ?? "0:0",
      bibleItemList: state.allTestamentList ?? [],
      abbrev: state.abbrev ?? "",
    );

    if (nextBibleVerse != null) {
      emit(
        BibleState(
          status: state.status,
          page: state.page,
          abbrev: nextBibleVerse.abbrev,
          verse: nextBibleVerse.verse,
          newTestamentList: state.newTestamentList,
          oldTestamentList: state.oldTestamentList,
          allTestamentList: state.allTestamentList,
          isFirstBiblePage: nextBibleVerse.isFirstBiblePage,
          isLastBiblePage: nextBibleVerse.isLastBiblePage,
        ),
      );
    }
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
        emit(
          BibleState(
            status: data == null ? BibleStatus.error : BibleStatus.success,
            page: state.page,
            abbrev: state.abbrev,
            chapter: state.chapter,
            verse: state.verse,
            newTestamentList: newTestamentList,
            oldTestamentList: oldTestamentList,
            allTestamentList: data,
            errorMessage: data == null ? "성경 데이터 조회 실패" : null,
          ),
        );
      },
    );
  }

  /// 성경 마지막 처음 페이지 여부
  bool? _isFirstPage({
    required BibleState state,
    required String verse,
  }) {
    final List<BibleChapterData>? bibleItemList = state.allTestamentList;
    int categoryIndex = 0;
    int chapterIndex = 0;

    if (bibleItemList != null) {
      for (int i = 0; i < bibleItemList.length; i++) {
        if ((state.abbrev ?? "") == bibleItemList[i].abbreviation) {
          categoryIndex = i;
          break;
        }
      }

      if (verse.isNotEmpty && verse.contains(":")) {
        try {
          List<String> chapterVerse = (verse).split(":");
          chapterIndex = int.parse(chapterVerse[0]);
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }

      return categoryIndex == 0 && chapterIndex == 0;
    } else {
      return null;
    }
  }

  /// 성경 마지막 페이지 여부
  bool? _isLastBiblePage({
    required BibleState state,
    required String verse,
  }) {
    final List<BibleChapterData>? bibleItemList = state.allTestamentList;
    int categoryIndex = 0;
    int chapterIndex = 0;

    if (bibleItemList != null) {
      for (int i = 0; i < bibleItemList.length; i++) {
        if ((state.abbrev ?? "") == bibleItemList[i].abbreviation) {
          categoryIndex = i;
          break;
        }
      }

      if (verse.isNotEmpty && verse.contains(":")) {
        try {
          List<String> chapterVerse = (verse).split(":");
          chapterIndex = int.parse(chapterVerse[0]);
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }

      return (categoryIndex == (bibleItemList.length) - 1 &&
          chapterIndex ==
              (bibleItemList[(bibleItemList.length) - 1].chapters.length) - 1);
    } else {
      return null;
    }
  }

  /// 성경 이전 장 조회
  BibleItemData? _getPreviousBibleVerse({
    required String nowStateVerse,
    required List<BibleChapterData> bibleItemList,
    required String abbrev,
  }) {
    BibleItemData? returnItem;
    try {
      int categoryIndex = 0;
      String returnAbbrev = abbrev;

      for (int i = 0; i < bibleItemList.length; i++) {
        if (abbrev == bibleItemList[i].abbreviation) {
          categoryIndex = i;
          returnAbbrev = bibleItemList[i].abbreviation;
          break;
        }
      }

      if (nowStateVerse.isNotEmpty && nowStateVerse.contains(":")) {
        final int chapter = int.parse(nowStateVerse.split(":").first);
        if (chapter > 0) {
          /// 구절의 장 - 1
          returnItem = BibleItemData(
            abbrev: returnAbbrev,
            verse: "${chapter - 1}:0",
            isFirstBiblePage: (chapter - 1) == 0,
            isLastBiblePage: false,
          );
        } else {
          /// 구절의 첫장이면 이전 구절의 마지막 장으로 이동
          if (categoryIndex > 0) {
            returnAbbrev = bibleItemList[categoryIndex - 1].abbreviation;
            returnItem = BibleItemData(
              abbrev: returnAbbrev,
              verse:
                  "${bibleItemList[categoryIndex - 1].chapters.length - 1}:0",
              isFirstBiblePage: (chapter - 1) == 0,
              isLastBiblePage: false,
            );
          }
        }

        return returnItem;
      }
    } catch (e) {
      return returnItem;
    }
    return returnItem;
  }

  /// 성경 다음 장 조회
  BibleItemData? _getNextBibleItem({
    required String nowStateVerse,
    required List<BibleChapterData> bibleItemList,
    required String abbrev,
  }) {
    BibleItemData? returnItem;
    try {
      int categoryIndex = 0;
      String returnAbbrev = abbrev;

      for (int i = 0; i < bibleItemList.length; i++) {
        if (abbrev == bibleItemList[i].abbreviation) {
          categoryIndex = i;
          returnAbbrev = bibleItemList[i].abbreviation;
          break;
        }
      }

      final int maxChapterIndex =
          bibleItemList[categoryIndex].chapters.length - 1;

      if (nowStateVerse.isNotEmpty && nowStateVerse.contains(":")) {
        final int chapter = int.parse(nowStateVerse.split(":").first);
        if (chapter < maxChapterIndex) {
          /// 구절의 장 + 1
          returnItem = BibleItemData(
            abbrev: returnAbbrev,
            verse: "${chapter + 1}:0",
            isFirstBiblePage: false,
            isLastBiblePage: (chapter + 1) == maxChapterIndex,
          );
        } else {
          /// 구절의 장이 마지막이면 다음 구절의 첫 장으로 이동
          if (categoryIndex < bibleItemList.length - 1) {
            returnAbbrev = bibleItemList[categoryIndex + 1].abbreviation;
            returnItem = BibleItemData(
              abbrev: returnAbbrev,
              verse: "0:0",
              isFirstBiblePage: false,
              isLastBiblePage: (chapter + 1) == maxChapterIndex,
            );
          }
        }

        return returnItem;
      }
    } catch (e) {
      return returnItem;
    }
    return returnItem;
  }
}
