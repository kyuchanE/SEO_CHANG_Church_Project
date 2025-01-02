import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/data/remote/remote_bible_json_data.dart';
import 'package:scmc_church_project/data/responses/bible_chapter_response.dart';
import 'package:scmc_church_project/domain/repository/bible_chapter_repository.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/data/to_domain.dart';
import 'dart:convert';

@LazySingleton(as: BibleChapterRepository)
class BibleChapterRepositoryImpl implements BibleChapterRepository {
  final RemoteBibleJsonData _remoteBibleJsonData;

  BibleChapterRepositoryImpl(this._remoteBibleJsonData);

  @override
  Future<Either<String, List<BibleChapterData>>> getBibleChapter() async {
    try {
      List<BibleChapterData> resultBibleChapter = [];
      String response = await _remoteBibleJsonData.getBibleChapter();
      List<dynamic> jsonResponse = json.decode(response);
      List<BibleChapterResponse> bibleChapterResponse =
          jsonResponse.map((e) => BibleChapterResponse.fromJson(e)).toList();
      for (var element in bibleChapterResponse) {
        resultBibleChapter.add(element.toDomain());
      }
      return resultBibleChapter;
    } catch (e) {
      return [];
    }
  }
}
