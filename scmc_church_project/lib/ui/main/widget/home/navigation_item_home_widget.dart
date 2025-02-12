import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/main_carousel_data.dart';
import 'package:scmc_church_project/domain/models/main_item_data.dart';
import 'package:scmc_church_project/ui/main/widget/home/carousel_item_widget.dart';

typedef OnTapCarouselItem = void Function(MainCarouselData mainCarouselData);

/// 네비게이션 아이템 홈 위젯
Widget navItemHomeWidget({
  required MainItemData? mainItemData,
  required double? maxWidth,
  required OnTapCarouselItem onTapCarouselItem,
}) {
  /// 캐러셀 위젯 리스트
  List<Widget> getCarouselWidgetList() {
    List<Widget> carouselWidgetList = [];
    if (mainItemData != null) {
      for (var element in mainItemData.mainCarousel) {
        carouselWidgetList.add(
          carouselItemWidget(
            width: maxWidth,
            mainCarouselData: element,
            onTapCarouselItem: onTapCarouselItem,
          ),
        );
      }
    }

    return carouselWidgetList;
  }

  return CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text('Carousel View'),
          background: Container(
            color: Colors.blue,
          ),
        ),
      ),
      // SliverToBoxAdapter(
      //   child: SizedBox(
      //     height: 10,
      //   ),
      // ),
      SliverToBoxAdapter(
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: getCarouselWidgetList(),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.amberAccent,
          height: 900.0,
          child: const Text("Home Screen!!!"),
        ),
      ),
    ],
  );
}
