import '../entities/loan_entity.dart';
import '../repositories/loan_repository.dart';

class LoanUsecase {
  final LoanRepository repository;

  LoanUsecase({required this.repository});

  Future<Loan> getLoan() {
    return repository.getLoan();
  }
}
