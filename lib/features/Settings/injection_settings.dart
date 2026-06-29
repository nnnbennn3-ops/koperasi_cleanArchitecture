import 'package:get_it/get_it.dart';
import 'data/datasources/settings_local_datasource.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/settings_usecase.dart';
import 'presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

void initSettingsInjection() {
  //Datasource
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(),
  );

  //Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsLocalDataSource>()),
  );

  //Usecases
  sl.registerLazySingleton<SettingsUsecase>(
    () => SettingsUsecase(repository: sl<SettingsRepository>()),
  );

  //Cubit
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(sl<SettingsUsecase>()));
}
