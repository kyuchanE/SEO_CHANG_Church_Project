import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/main_carousel_data.dart';
import 'package:scmc_church_project/ui/detail/full_screen_image_screen.dart';

class MainCarouselDetailScreen extends StatefulWidget {
  final MainCarouselData data;

  const MainCarouselDetailScreen({super.key, required this.data});

  @override
  State<MainCarouselDetailScreen> createState() =>
      _MainCarouselDetailScreenState();
}

class _MainCarouselDetailScreenState extends State<MainCarouselDetailScreen> {
  MainCarouselData get data => widget.data;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          /// 이미지 슬라이더
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FullScreenImageScreen(
                          images: data.contentsImages,
                        ),
                      ),
                    );
                  },
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: data.contentsImages.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: data.contentsImages.map((url) {
                  int index = data.contentsImages.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          /// 날짜
          Text(data.date),

          /// 본문 내용
          Text(data.contents),
        ],
      ),
    );
  }
}
