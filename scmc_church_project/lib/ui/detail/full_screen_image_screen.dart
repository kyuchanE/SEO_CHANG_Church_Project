import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullScreenImageScreen extends StatefulWidget {
  final List<String> images;
  const FullScreenImageScreen({super.key, required this.images});

  @override
  State<FullScreenImageScreen> createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fullscreen sliding carousel demo'),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlay: false,
              // autoPlay: false,
            ),
            items: widget.images
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.contain,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
