import '../entities/loan_entity.dart';

abstract class LoanRepository {
  Future<Loan> getLoan();
}
