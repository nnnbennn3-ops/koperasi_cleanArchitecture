import '../../domain/entities/loan.dart';
import '../../domain/repositories/loan_repository.dart';
import '../datasources/loan_local_datasource.dart';

class LoanRepositoryImpl implements LoanRepository {
  final LoanLocalDataSource localDataSource;

  LoanRepositoryImpl(this.localDataSource);

  @override
  Future<Loan> getLoan() {
    return localDataSource.getLoan();
  }
}
