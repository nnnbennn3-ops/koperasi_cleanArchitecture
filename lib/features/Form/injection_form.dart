import 'package:get_it/get_it.dart';

import 'data/datasources/form_local_datasource.dart';
import 'data/repositories/form_repository_impl.dart';
import 'domain/repositories/form_repository.dart';
import 'domain/usecases/get_forms.dart';
import 'presentation/cubit/form_cubit.dart';

final sl = GetIt.instance;

void initFormInjection() {
  sl.registerLazySingleton<FormLocalDataSource>(() => FormLocalDataSource());
  sl.registerLazySingleton<FormRepository>(
    () => FormRepositoryImpl(sl<FormLocalDataSource>()),
  );
  sl.registerLazySingleton<GetForms>(() => GetForms(sl<FormRepository>()));
  sl.registerFactory<FormCubit>(() => FormCubit(sl<GetForms>()));
}
