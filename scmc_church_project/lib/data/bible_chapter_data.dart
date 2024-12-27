class BibleChapterData {
  String abbreviation;
  String name;
  List<List<String>> chapters;

  BibleChapterData({
    required this.abbreviation,
    required this.name,
    required this.chapters,
  });

  // Factory constructor to create a BibleBook from JSON
  factory BibleChapterData.fromJson(Map<String, dynamic> json) {
    return BibleChapterData(
      abbreviation: json['abbrev'],
      name: json['name_kr'],
      chapters: List<List<String>>.from(
        json['chapters'].map((chapter) => List<String>.from(chapter)),
      ),
    );
  }

  // Method to convert a BibleBook to JSON
  Map<String, dynamic> toJson() {
    return {
      'abbrev': abbreviation,
      'name_kr': name,
      'chapters': chapters.map((chapter) => chapter.toList()).toList(),
    };
  }
}
