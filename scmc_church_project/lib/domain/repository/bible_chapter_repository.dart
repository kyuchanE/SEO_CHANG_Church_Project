import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:dartz/dartz.dart';

abstract class BibleChapterRepository {
  Future<Either<String, List<BibleChapterData>>> getBibleChapter();
}
