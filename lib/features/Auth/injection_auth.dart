import 'package:get_it/get_it.dart';

import 'data/datasources/auth_local_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login.dart';
import 'presentation/cubit/auth_cubit.dart';
import '../../../core/services/secure_storage_service.dart';

final sl = GetIt.instance;

void initAuthInjection() {
  // SERVICE LUAR
  sl.registerLazySingleton(() => SecureStorageService());

  // DATASOURCE
  sl.registerLazySingleton(() => AuthLocalDataSource());

  // REPOSITORY
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthLocalDataSource>(),
      sl<SecureStorageService>(),
    ),
  );

  // USECASE
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));

  // CUBIT
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(sl<Login>(), sl<SecureStorageService>()),
  );
}
