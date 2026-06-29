import 'package:get_it/get_it.dart';

import 'data/datasources/loan_local_datasource.dart';
import 'data/repositories/loan_repository_impl.dart';
import 'domain/repositories/loan_repository.dart';
import 'domain/usecases/get_loan_usecase.dart';
import 'presentation/cubit/loan_cubit.dart';

final sl = GetIt.instance;

void initLoanInjection() {
  sl.registerLazySingleton<LoanLocalDataSource>(() => LoanLocalDataSource());
  sl.registerLazySingleton<LoanRepository>(
    () => LoanRepositoryImpl(sl<LoanLocalDataSource>()),
  );
  sl.registerLazySingleton<LoanUsecase>(
    () => LoanUsecase(repository: sl<LoanRepository>()),
  );
  sl.registerFactory<LoanCubit>(() => LoanCubit(sl<LoanUsecase>()));
}
