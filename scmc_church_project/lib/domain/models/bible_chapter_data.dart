class BibleChapterData {
  final String abbreviation;
  final String name;
  final List<List<String>> chapters;
  final bool isOldTestament;

  const BibleChapterData({
    required this.abbreviation,
    required this.name,
    required this.chapters,
    required this.isOldTestament,
  });
}
