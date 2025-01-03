import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';

/// 성경 페이지
enum BiblePage {
  bibleCategory,
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
  final String category;
  final int chapter;
  final int verse;
  final List<BibleChapterData>? bibleChapterData;
  final String? errorMessage;

  BibleState({
    this.status = BibleStatus.loading,
    this.page = BiblePage.bibleCategory,
    this.category = '',
    this.chapter = 1,
    this.verse = 1,
    this.bibleChapterData,
    this.errorMessage,
  });

  BibleState copyWith({
    BibleStatus? status,
    BiblePage? page,
    String? category,
    int? chapter,
    int? verse,
    List<BibleChapterData>? bibleChapterData,
    String? errorMessage,
  }) {
    return BibleState(
      status: status ?? this.status,
      page: page ?? this.page,
      category: category ?? this.category,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      bibleChapterData: bibleChapterData ?? this.bibleChapterData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
