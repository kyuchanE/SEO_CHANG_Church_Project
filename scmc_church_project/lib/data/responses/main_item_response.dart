class MainItemResponse {
  final List<MainCarouselResponse> mainCarousel;

  MainItemResponse({
    required this.mainCarousel,
  });
}

class MainCarouselResponse {
  final String title;
  final String contents;
  final String imageUrl;
  final String date;
  final List<String> contentsImages;

  MainCarouselResponse({
    required this.title,
    required this.contents,
    required this.imageUrl,
    required this.date,
    required this.contentsImages,
  });

  factory MainCarouselResponse.fromJson(Map<String, dynamic> json) =>
      MainCarouselResponse(
        title: json['title'],
        contents: json['contents'],
        imageUrl: json['image'],
        date: json['date'],
        contentsImages: List<String>.from(json['contentsImages']),
      );
}
