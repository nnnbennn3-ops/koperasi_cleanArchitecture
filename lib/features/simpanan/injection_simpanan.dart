import 'package:get_it/get_it.dart';
import 'data/datasource/simpanan_local_datasource.dart';
import 'data/repositories/simpanan_repository_impl.dart';
import 'domain/repositories/simpanan_repository.dart';
import 'domain/usecases/get_simpanan_usecase.dart';
import 'presentation/cubit/simpanan_cubit.dart';

final sl = GetIt.instance;

void initSimpananInjection() {
  sl.registerLazySingleton<SimpananLocalDataSource>(
    () => SimpananLocalDataSource(),
  );
  sl.registerLazySingleton<SimpananRepository>(
    () => SimpananRepositoryImpl(sl<SimpananLocalDataSource>()),
  );
  sl.registerLazySingleton<SimpananUsecase>(
    () => SimpananUsecase(repository: sl<SimpananRepository>()),
  );
  sl.registerFactory<SimpananCubit>(() => SimpananCubit(sl<SimpananUsecase>()));
}
