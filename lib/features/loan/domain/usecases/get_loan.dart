import '../entities/loan.dart';
import '../repositories/loan_repository.dart';

class GetLoan {
  final LoanRepository repository;

  GetLoan(this.repository);

  Future<Loan> call() {
    return repository.getLoan();
  }
}
