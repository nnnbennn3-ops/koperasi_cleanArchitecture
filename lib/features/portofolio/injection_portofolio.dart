import 'package:get_it/get_it.dart';
import 'data/datasource/portofolio_local_datasource.dart';
import 'data/repositories/portofolio_repository_impl.dart';
import 'domain/repositories/portofolio_repository.dart';
import 'domain/usecases/get_portofolio_usecase.dart';
import 'presentation/cubit/portofolio_cubit.dart';

final sl = GetIt.instance;

void initPortofolioInjection() {
  sl.registerLazySingleton<PortofolioLocalDataSource>(
    () => PortofolioLocalDataSource(),
  );
  sl.registerLazySingleton<PortofolioRepository>(
    () => PortofolioRepositoryImpl(sl<PortofolioLocalDataSource>()),
  );
  sl.registerLazySingleton<PortofolioUsecase>(
    () => PortofolioUsecase(repository: sl<PortofolioRepository>()),
  );
  sl.registerFactory<PortofolioCubit>(
    () => PortofolioCubit(sl<PortofolioUsecase>()),
  );
}
