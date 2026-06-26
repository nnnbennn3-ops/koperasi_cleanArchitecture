import 'package:get_it/get_it.dart';
import 'data/datasources/settings_local_datasource.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/get_profile.dart';
import 'domain/usecases/update_bank.dart';
import 'domain/usecases/change_password.dart';
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
  sl.registerLazySingleton(() => GetProfile(sl<SettingsRepository>()));
  sl.registerLazySingleton(() => UpdateBank(sl<SettingsRepository>()));
  sl.registerLazySingleton(() => ChangePassword(sl<SettingsRepository>()));

  //Cubit
  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      getProfile: sl<GetProfile>(),
      updateBank: sl<UpdateBank>(),
      changePassword: sl<ChangePassword>(),
    ),
  );
}
