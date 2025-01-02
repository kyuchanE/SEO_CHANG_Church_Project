class VersionResponse {
  final String minAndroid;
  final String minIos;
  final String targetAndroid;
  final String targetIos;

  VersionResponse({
    required this.minAndroid,
    required this.minIos,
    required this.targetAndroid,
    required this.targetIos,
  });

  /// Factory constructor to create a VersionData from JSON
  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      VersionResponse(
        minAndroid: json['min_android'],
        minIos: json['min_ios'],
        targetAndroid: json['target_android'],
        targetIos: json['target_ios'],
      );

  /// Method to convert a BibleBook to JSON
  Map<String, dynamic> toJson() => {
        'min_android': minAndroid,
        'min_ios': minIos,
        'target_android': targetAndroid,
        'target_ios': targetIos,
      };
}
