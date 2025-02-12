import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/main_carousel_data.dart';

typedef OnTapCarouselItem = void Function(MainCarouselData mainCarouselData);

Widget carouselItemWidget({
  required double? width,
  required MainCarouselData mainCarouselData,
  required OnTapCarouselItem onTapCarouselItem,
}) {
  return SizedBox(
    width: width,
    height: width == null ? 300 : width * 0.8,
    child: InkWell(
      /// 클릭 이벤트
      onTap: () => onTapCarouselItem(mainCarouselData),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            /// 이미지 배경
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                mainCarouselData.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// Title , Date
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(mainCarouselData.title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(mainCarouselData.date),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
