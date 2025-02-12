import 'package:dartz/dartz.dart';
import 'package:scmc_church_project/domain/models/main_item_data.dart';

abstract class MainItemRepository {
  Future<Either<String, MainItemData>> getMainItem();
}
