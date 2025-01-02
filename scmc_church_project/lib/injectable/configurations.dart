import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scmc_church_project/data/network/firebase_firestore.dart';
import 'package:scmc_church_project/data/remote/remote_firestore_data.dart';
import 'package:scmc_church_project/data/remote/remote_firestore_data_impl.dart';

import 'configurations.config.dart' as config;

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() => $initGetIt(getIt);

Future<void> $initGetIt(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  final gh = GetItHelper(getIt, environment.toString());

  /// Firebase Firestore 서비스 등록
  gh.factory<FirebaseFirestore>(
      () => FirebaseFiestoreService().getFirebaseFirestore());

  /// Firebase Firestore 서비스를 사용하는 원격 데이터 소스 등록
  gh.factory<RemoteFirestoreData>(
      () => RemoteFirestoreDataImpl(getIt<FirebaseFirestore>()));

  config.$initGetIt(getIt);
}
