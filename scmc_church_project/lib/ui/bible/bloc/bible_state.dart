import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';

/// 성경 페이지
enum BiblePage {
  bibleCategory,
  bibleChapter,
  bibleResult,
}

/// 성경 데이터 조회 상태
enum BibleStatus {
  loading,
  success,
  error,
}

class BibleState {
  final BibleStatus status;
  final BiblePage page;
  final String? abbrev; // 성경 약자
  final int? chapter; // 장 Index
  final String? verse; // 장:절 ex) 1:1
  final List<BibleChapterData>? newTestamentList; // 신약 성경 데이터
  final List<BibleChapterData>? oldTestamentList; // 구약 성경 데이터
  final List<BibleChapterData>? allTestamentList; // 전체 성경 데이터
  final String? errorMessage; // 에러 메시지
  final bool isFirstBiblePage; // 성경 처음 페이지 여부
  final bool isLastBiblePage; // 성경 마지막 페이지 여부

  BibleState({
    this.status = BibleStatus.loading,
    this.page = BiblePage.bibleCategory,
    this.abbrev,
    this.chapter,
    this.verse,
    this.newTestamentList,
    this.oldTestamentList,
    this.allTestamentList,
    this.errorMessage,
    this.isFirstBiblePage = false,
    this.isLastBiblePage = false,
  });

  BibleState copyWith({
    BibleStatus? status,
    BiblePage? page,
    String? abbrev,
    int? chapter,
    String? verse,
    List<BibleChapterData>? newTestamentList,
    List<BibleChapterData>? oldTestamentList,
    List<BibleChapterData>? allTestamentList,
    String? errorMessage,
    bool? isFirstPage,
    bool? isLastPage,
  }) {
    return BibleState(
      status: status ?? this.status,
      page: page ?? this.page,
      abbrev: abbrev ?? this.abbrev,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      oldTestamentList: oldTestamentList ?? this.oldTestamentList,
      newTestamentList: newTestamentList ?? this.newTestamentList,
      allTestamentList: allTestamentList ?? this.allTestamentList,
      errorMessage: errorMessage ?? this.errorMessage,
      isFirstBiblePage: isFirstPage ?? this.isFirstBiblePage,
      isLastBiblePage: isLastPage ?? this.isLastBiblePage,
    );
  }
}
