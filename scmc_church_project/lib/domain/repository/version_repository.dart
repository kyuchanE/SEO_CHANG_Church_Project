import 'package:dartz/dartz.dart';
import 'package:scmc_church_project/domain/models/version_data.dart';

abstract class VersionRepository {
  Future<Either<String, VersionData>> getVersion();
}
