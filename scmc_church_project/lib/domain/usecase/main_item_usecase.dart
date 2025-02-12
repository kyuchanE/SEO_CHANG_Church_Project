import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/domain/models/main_item_data.dart';
import 'package:scmc_church_project/domain/repository/main_item_repository.dart';
import 'package:scmc_church_project/domain/usecase/base_usecase.dart';

@injectable
class MainItemUsecase implements BaseUseCase<void, MainItemData> {
  final MainItemRepository _mainItemRepository;

  MainItemUsecase(this._mainItemRepository);

  @override
  Future<Either<String, MainItemData>> execute(void _) async {
    return await _mainItemRepository.getMainItem();
  }
}
