import 'package:flutter/material.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';

/// 성경 장/절 선택
Widget bibleChapterBody({
  required BibleChapterData? selectedData,
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: Center(
      child: Text(
        'result : ${selectedData?.name}',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}
