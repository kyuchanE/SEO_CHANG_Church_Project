import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:scmc_church_project/data/remote/remote_firestore_data.dart';
import 'package:scmc_church_project/data/responses/main_item_response.dart';
import 'package:scmc_church_project/data/to_domain.dart';
import 'package:scmc_church_project/domain/models/main_carousel_data.dart';
import 'package:scmc_church_project/domain/models/main_item_data.dart';
import 'package:scmc_church_project/domain/repository/main_item_repository.dart';

@LazySingleton(as: MainItemRepository)
class MainItemRepositoryImpl implements MainItemRepository {
  final RemoteFirestoreData _remoteFirestoreData;

  MainItemRepositoryImpl(this._remoteFirestoreData);

  @override
  Future<Either<String, MainItemData>> getMainItem() async {
    try {
      var snapshotMainCarouselItem =
          await _remoteFirestoreData.getMainCarouselItem();
      List<MainCarouselResponse> mainCarouselItemList = [];

      snapshotMainCarouselItem.docs.forEach((element) {
        log('element.data() ${element.data()}');
        mainCarouselItemList.add(MainCarouselResponse.fromJson(element.data()));
      });

      MainItemResponse mainItemResponse =
          MainItemResponse(mainCarousel: mainCarouselItemList);

      List<MainCarouselData> mainCarouselToDomainList = [];
      for (var element in mainItemResponse.mainCarousel) {
        mainCarouselToDomainList.add(element.toDomain());
      }

      return Right(MainItemData(
        mainCarousel: mainCarouselToDomainList,
      ));
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
