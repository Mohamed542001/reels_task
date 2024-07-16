import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/feature/cubit/reels_cubit.dart';

import '../../features/feature/data/feature_data_source/reels_data_source.dart';
import '../../features/feature/data/repository/reels_repository.dart';
import '../network/dio_helper.dart';
import '../src/app_export.dart';

final getIt = GetIt.instance;

void initGetIt() {
  /// BLoC
  getIt.registerFactory<ReelsBloc>(() => ReelsBloc(getIt()));
  getIt.registerFactory<LocalizationBloc>(() => LocalizationBloc());

  /// Data Sources
  getIt.registerLazySingleton<ReelsDataSource>(
      () => ReelsDataSource(getIt()));


  /// Repository
  getIt.registerLazySingleton<ReelsRepository>(
      () => ReelsRepository(getIt()));


  /// SharedPreferences
  getIt.registerSingletonAsync<SharedPreferences>(
          () async => await SharedPreferences.getInstance());

  /// Dio
  getIt.registerLazySingleton<BaseDioHelper>(() => DioHelper());
}
