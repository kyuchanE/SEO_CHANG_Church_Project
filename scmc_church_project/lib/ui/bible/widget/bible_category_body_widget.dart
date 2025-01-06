import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/bible/bloc/bible_state.dart';

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
  return GridView.builder(
    padding: const EdgeInsets.all(16.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Number of columns
      crossAxisSpacing: 5, // Spacing between columns
      mainAxisSpacing: 5, // Spacing between rows
    ),
    itemCount: testamentList == null ? 0 : testamentList.length,
    itemBuilder: (context, index) {
      return _bibleGrideItem(
        abbrev: testamentList![index].abbreviation,
        name: testamentList![index].name,
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
}) {
  return InkWell(
    onTap: () => onTapCallback(abbrev),
    child: Card(
      color: Colors.yellowAccent,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _circularTextWidget(abbrev),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _circularTextWidget(String abbrev) {
  return Container(
    width: 40.0, // Width of the circle
    height: 40.0, // Height of the circle
    decoration: BoxDecoration(
      color: Colors.grey, // Background color of the circle
      shape: BoxShape.circle, // Makes the container a circle
    ),
    child: Center(
      child: Text(
        abbrev,
        style: const TextStyle(
          color: Colors.white, // Text color
          fontSize: 20.0, // Text size
          fontWeight: FontWeight.bold, // Text weight
        ),
        textAlign: TextAlign.center, // Center align the text
      ),
    ),
  );
}
