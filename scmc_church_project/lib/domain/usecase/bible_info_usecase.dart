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
    /// TODO: Save or not?
    /// 여기서 내부 저장소에 미리 저장해두는게 좋을까?
    /// 호출 타이밍은 항상 인트로에서 받는걸로? 내부 저장소에 이미 값이 있다면?
    return await _bibleChapterRepository.getBibleChapter();
  }
}
