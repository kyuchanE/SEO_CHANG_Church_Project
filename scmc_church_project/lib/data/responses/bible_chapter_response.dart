class BibleChapterResponse {
  String abbreviation;
  String name;
  List<List<String>> chapters;

  BibleChapterResponse({
    required this.abbreviation,
    required this.name,
    required this.chapters,
  });

  /// Factory constructor to create a BibleBook from JSON
  factory BibleChapterResponse.fromJson(Map<String, dynamic> json) =>
      BibleChapterResponse(
        abbreviation: json['abbrev'],
        name: json['name_kr'],
        chapters: List<List<String>>.from(
          json['chapters'].map((chapter) => List<String>.from(chapter)),
        ),
      );

  /// Method to convert a BibleBook to JSON
  Map<String, dynamic> toJson() => {
        'abbrev': abbreviation,
        'name_kr': name,
        'chapters': chapters.map((chapter) => chapter).toList(),
      };
}
