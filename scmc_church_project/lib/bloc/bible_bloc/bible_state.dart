/// 성경 페이지
enum BiblePage {
  bibleCategory,
  bibleResult,
}

class BibleState {
  final BiblePage page;
  final String category;
  final int chapter;
  final int verse;

  BibleState({
    this.page = BiblePage.bibleCategory,
    this.category = '',
    this.chapter = 1,
    this.verse = 1,
  });

  BibleState copyWith({
    BiblePage? page,
    String? category,
    int? chapter,
    int? verse,
  }) {
    return BibleState(
      page: page ?? this.page,
      category: category ?? this.category,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
    );
  }
}
