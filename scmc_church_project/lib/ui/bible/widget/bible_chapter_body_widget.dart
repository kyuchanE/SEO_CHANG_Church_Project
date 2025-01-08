import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/ui/bible/page/select_bible_chapter_screen.dart';

/// 성경 장/절 선택
Widget bibleChapterBody({
  required BibleChapterData? selectedData,
  int selectedLeftIndex = 0,
  int? selectedRightIndex,
  required OnTapBibleChapterCallback onTapBibleChapter,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 35.0,
      right: 15.0,
      left: 15.0,
      bottom: 60.0,
    ),
    child: Container(
      height: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// 성경 장 선택 리스트
          Expanded(
            flex: 1,
            child: _bibleChapterListWidget(
              itemCount: selectedData?.chapters.length ?? 0,
              selectedIndex: selectedLeftIndex,
              onTapBibleChapter: onTapBibleChapter,
            ),
          ),

          /// 성경 절 선택 리스트
          Expanded(
            flex: 1,
            child: _bibleChapterListWidget(
              itemCount: selectedData?.chapters[selectedLeftIndex].length ?? 0,
              selectedIndex: selectedRightIndex ?? -1,
              isLeft: false,
              onTapBibleChapter: onTapBibleChapter,
            ),
          ),
        ],
      ),
    ),
  );
}

/// 성경 장/구절 선택 리스트
Widget _bibleChapterListWidget({
  required int itemCount,
  required int selectedIndex,
  bool isLeft = true,
  required OnTapBibleChapterCallback onTapBibleChapter,
}) {
  return ListView.builder(
    itemCount: itemCount,
    itemBuilder: (context, index) {
      /// ListTitle만 사용하면 bg값이 안먹음 (Material로 감싸줘야함)
      return Material(
        child: ListTile(
          title: Text(
            isLeft == true ? "${index + 1} 장" : "${index + 1} 절",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          selected: selectedIndex == index,
          selectedTileColor: Colors.black.withOpacity(0.1),
          tileColor: Colors.white,
          enableFeedback: true,
          titleAlignment: ListTileTitleAlignment.center,
          onTap: () {
            onTapBibleChapter(
              leftIndex: isLeft == true ? index : null,
              rightIndex: isLeft == true ? null : index,
            );
          },
        ),
      );
    },
  );
}
