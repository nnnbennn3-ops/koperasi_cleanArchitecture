import 'package:get_it/get_it.dart';

import 'data/datasources/auth_local_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/register.dart';
import 'presentation/cubit/auth_cubit.dart';
import '../../../core/services/secure_storage_service.dart';

final sl = GetIt.instance;

void initAuthInjection() {
  // SERVICE
  if (!sl.isRegistered<SecureStorageService>()) {
    sl.registerLazySingleton(() => SecureStorageService());
  }

  // DATASOURCE
  sl.registerLazySingleton(() => AuthLocalDataSource());

  // REPOSITORY
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthLocalDataSource>(),
      sl<SecureStorageService>(),
    ),
  );

  // USECASES
  sl.registerLazySingleton(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Register(sl<AuthRepository>()));

  // CUBIT
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(sl<Login>(), sl<Register>(), sl<SecureStorageService>()),
  );
}
