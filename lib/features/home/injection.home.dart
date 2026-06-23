import 'package:get_it/get_it.dart';
import 'data/datasources/home_local_datasource.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_home.dart';
import 'presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

void initHomeInjection() {
  sl.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSource());
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeLocalDataSource>()),
  );
  sl.registerLazySingleton<GetHome>(() => GetHome(sl<HomeRepository>()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl<GetHome>()));
}
