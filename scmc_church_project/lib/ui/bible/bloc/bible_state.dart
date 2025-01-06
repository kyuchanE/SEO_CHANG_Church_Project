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
  final String? abbrev;
  final int? chapter;
  final int? verse;
  final List<BibleChapterData>? newTestamentList;
  final List<BibleChapterData>? oldTestamentList;
  final List<BibleChapterData>? allTestamentList;
  final String? errorMessage;

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
  });

  BibleState copyWith({
    BibleStatus? status,
    BiblePage? page,
    String? abbrev,
    int? chapter,
    int? verse,
    List<BibleChapterData>? newTestamentList,
    List<BibleChapterData>? oldTestamentList,
    List<BibleChapterData>? allTestamentList,
    String? errorMessage,
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
    );
  }
}
