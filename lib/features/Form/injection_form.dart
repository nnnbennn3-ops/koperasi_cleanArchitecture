import 'package:get_it/get_it.dart';

import 'data/datasources/form_local_datasource.dart';
import 'data/repositories/form_repository_impl.dart';
import 'domain/usecases/get_forms.dart';
import 'presentation/cubit/form_cubit.dart';

final sl = GetIt.instance;

void initFormInjection() {
  sl.registerLazySingleton(() => FormLocalDataSource());
  sl.registerLazySingleton(() => FormRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetForms(sl()));
  sl.registerFactory(() => FormCubit(sl()));
}
