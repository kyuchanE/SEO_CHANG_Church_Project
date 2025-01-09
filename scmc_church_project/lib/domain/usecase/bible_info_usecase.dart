import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/bible_chapter_data.dart';
import 'package:scmc_church_project/domain/usecase/base_usecase.dart';
import 'package:scmc_church_project/domain/repository/bible_chapter_repository.dart';
import 'package:dartz/dartz.dart';

@injectable
class BibleInfoUsecase implements BaseUseCase<void, List<BibleChapterData>?> {
  final BibleChapterRepository _bibleChapterRepository;

  BibleInfoUsecase(this._bibleChapterRepository);

  @override
  Future<Either<String, List<BibleChapterData>?>> execute(_) async {
    return await _bibleChapterRepository.getBibleChapter();
  }
}
