import 'package:get_it/get_it.dart';

import 'data/datasources/loan_local_datasource.dart';
import 'data/repositories/loan_repository_impl.dart';
import 'domain/usecases/get_loan.dart';
import 'presentation/cubit/loan_cubit.dart';

final sl = GetIt.instance;

void initLoanInjection() {
  sl.registerLazySingleton(() => LoanLocalDataSource());
  sl.registerLazySingleton(() => LoanRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetLoan(sl()));
  sl.registerFactory(() => LoanCubit(sl()));
}
