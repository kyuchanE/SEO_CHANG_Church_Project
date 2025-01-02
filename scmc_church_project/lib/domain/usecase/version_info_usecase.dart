import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/version_data.dart';
import 'package:scmc_church_project/domain/usecase/base_usecase.dart';
import 'package:scmc_church_project/domain/repository/version_repository.dart';

@injectable
class VersionInfoUsecase implements BaseUseCase<void, VersionData?> {
  final VersionRepository _versionRepository;

  VersionInfoUsecase(this._versionRepository);

  @override
  Future<Either<String, VersionData?>> execute(void input) async {
    return await _versionRepository.getVersion();
  }
}
