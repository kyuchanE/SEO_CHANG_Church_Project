class BibleItemData {
  final String abbrev;
  final String verse; // 장:절 ex) 1:1
  final bool isFirstBiblePage;
  final bool isLastBiblePage;

  BibleItemData({
    required this.abbrev,
    required this.verse,
    required this.isFirstBiblePage,
    required this.isLastBiblePage,
  });
}
