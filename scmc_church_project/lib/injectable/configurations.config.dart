// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/remote/remote_firestore_data.dart' as _i795;
import '../data/repository/bible_chapter_repository_impl.dart' as _i23;
import '../data/repository/version_repository_impl.dart' as _i228;
import '../domain/repository/version_repository.dart' as _i77;
import '../domain/usecase/version_info_usecase.dart' as _i245;
import '../ui/splash/bloc/splash_init_bloc.dart' as _i320;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i77.VersionRepository>(
      () => _i228.VersionRepositoryImpl(gh<_i795.RemoteFirestoreData>()));
  gh.lazySingleton<_i23.BibleChapterRepositoryImpl>(
      () => _i23.BibleChapterRepositoryImpl(gh<InvalidType>()));
  gh.factory<_i245.VersionInfoUsecase>(
      () => _i245.VersionInfoUsecase(gh<_i77.VersionRepository>()));
  gh.factory<_i320.SplashInitBloc>(
      () => _i320.SplashInitBloc(gh<_i245.VersionInfoUsecase>()));
  return getIt;
}
