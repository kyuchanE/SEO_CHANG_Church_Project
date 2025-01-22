import 'package:flutter/material.dart';
import 'package:scmc_church_project/core/resources/config.dart';
import 'package:scmc_church_project/core/utils/utils_extension.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';
import 'package:scmc_church_project/ui/bible/page/bible_result_screen.dart';
import 'package:scmc_church_project/ui/common/common_ui_config.dart';

typedef OnTapBibleCategoryCallback = void Function(String abbrev);

/// 성경 구약/신약 선택
Widget bibleCategoryBody({
  required BibleState state,
  required TabController tabController,
  required OnTapBibleCategoryCallback onTapCallback,
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: Column(
      children: [
        _bibleCategoryTabBar(
          tabController: tabController,
        ),
        Expanded(
          flex: 1,
          child: _bibleCategoryTabBarView(
            tabController: tabController,
            oldTestamentList: state.oldTestamentList,
            newTestamentList: state.newTestamentList,
            onTapCallback: onTapCallback,
          ),
        ),
      ],
    ),
  );
}

/// 상단 탭
Widget _bibleCategoryTabBar({required TabController tabController}) {
  return TabBar(
    controller: tabController,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: const EdgeInsets.only(left: 15, right: 15),
    labelColor: Colors.black,
    unselectedLabelColor: Colors.black45,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    tabs: [
      Tab(text: "구약"),
      Tab(text: "신약"),
    ],
  );
}

/// 탭뷰
Widget _bibleCategoryTabBarView({
  required TabController tabController,
  required List<BibleChapterData>? oldTestamentList,
  required List<BibleChapterData>? newTestamentList,
  required OnTapBibleCategoryCallback onTapCallback,
}) {
  return TabBarView(
    controller: tabController,
    children: [
      _bibleCategoryGrideList(
        testamentList: oldTestamentList,
        onTapCallback: onTapCallback,
      ),
      _bibleCategoryGrideList(
        testamentList: newTestamentList,
        onTapCallback: onTapCallback,
      ),
    ],
  );
}

/// 성경 구약/신약 그리드 리스트
Widget _bibleCategoryGrideList({
  required List<BibleChapterData>? testamentList,
  required OnTapBibleCategoryCallback onTapCallback,
}) {
  if (testamentList == null) {
    return Container();
  }
  return GridView.builder(
    padding: const EdgeInsets.all(16.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Number of columns
      crossAxisSpacing: 5, // Spacing between columns
      mainAxisSpacing: 5, // Spacing between rows
    ),
    itemCount: testamentList.length,
    itemBuilder: (context, index) {
      return _bibleGrideItem(
        abbrev: testamentList[index].abbreviation,
        name: testamentList[index].name,
        bgAssets: testamentList[index].abbreviation.bibleItemAssets(),
        onTapCallback: onTapCallback,
      );
    },
  );
}

/// 성경 구약/신약 그리드 아이템
Widget _bibleGrideItem({
  required String abbrev,
  required String name,
  required OnTapBibleCategoryCallback onTapCallback,
  String bgAssets = bibleDefaultImg,
}) {
  return InkWell(
      onTap: () => onTapCallback(abbrev),
      child: _bgImageCard(abbrev, name, bgAssets: bgAssets));
}

Widget _bgImageCard(
  String abbrev,
  String name, {
  String bgAssets = bibleDefaultImg,
}) {
  return Card(
    color: Colors.transparent,
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: bibleItemBorderRadius,
    ),
    child: Stack(
      children: [
        /// Background - Image Opacity
        ClipRRect(
          borderRadius: bibleItemBorderRadius,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.dstATop,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FadeInImage(
                placeholder: const AssetImage(biblePlaceHolder),
                image: AssetImage(bgAssets),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, _) {
                  return Image.asset(
                    biblePlaceHolder,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),

        /// Content of the card
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _circularTextWidget(abbrev),
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    color: Colors.white.withOpacity(0.3),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _circularTextWidget(String abbrev) {
  return Container(
    width: 60.0, // Width of the circle
    height: 60.0, // Height of the circle
    decoration: BoxDecoration(
      color: Colors.grey, // Background color of the circle
      shape: BoxShape.circle, // Makes the container a circle
    ),
    child: Center(
      child: Text(
        abbrev,
        style: const TextStyle(
          color: Colors.white, // Text color
          fontSize: 30.0, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
        textAlign: TextAlign.center, // Center align the text
      ),
    ),
  );
}
