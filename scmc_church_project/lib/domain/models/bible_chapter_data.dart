class BibleChapterData {
  final String abbreviation;
  final String name;
  final List<List<String>> chapters;
  final bool isOldTestament;
  final String summary;

  const BibleChapterData({
    required this.abbreviation,
    required this.name,
    required this.chapters,
    required this.isOldTestament,
    required this.summary,
  });
}
