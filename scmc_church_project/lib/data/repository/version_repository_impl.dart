import 'package:injectable/injectable.dart';
import 'package:scmc_church_project/data/responses/version_response.dart';
import 'package:scmc_church_project/data/to_domain.dart';
import 'package:scmc_church_project/domain/models/version_data.dart';
import 'package:scmc_church_project/domain/repository/version_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:scmc_church_project/data/remote/remote_firestore_data.dart';
import 'dart:convert';

@LazySingleton(as: VersionRepository)
class VersionRepositoryImpl implements VersionRepository {
  final RemoteFirestoreData _remoteFirestoreData;

  VersionRepositoryImpl(this._remoteFirestoreData);

  @override
  Future<Either<String, VersionData>> getVersion() async {
    try {
      var snapshotVersionData = await _remoteFirestoreData.getVersion();
      VersionResponse versionResponse =
          VersionResponse.fromJson(snapshotVersionData.docs.first.data());
      return Right(versionResponse.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
