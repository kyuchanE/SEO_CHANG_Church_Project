class BibleChapterResponse {
  String abbreviation;
  String name;
  List<List<String>> chapters;
  bool isOldTestament;
  String bgAssets;
  String summary;

  BibleChapterResponse({
    required this.abbreviation,
    required this.name,
    required this.chapters,
    required this.isOldTestament,
    required this.bgAssets,
    required this.summary,
  });

  /// Factory constructor to create a BibleBook from JSON
  factory BibleChapterResponse.fromJson(Map<String, dynamic> json) =>
      BibleChapterResponse(
        abbreviation: json['abbrev_ko'],
        name: json['name_kr'],
        bgAssets: json['bg_assets'],
        summary: json['summary'],
        isOldTestament: json['isOldTestament'],
        chapters: List<List<String>>.from(
          json['chapters'].map((chapter) => List<String>.from(chapter)),
        ),
      );

  /// Method to convert a BibleBook to JSON
  Map<String, dynamic> toJson() => {
        'abbrev_ko': abbreviation,
        'name_kr': name,
        'bg_assets': bgAssets,
        'summary': summary,
        'chapters': chapters.map((chapter) => chapter).toList(),
        'isOldTestament': isOldTestament,
      };
}
