import '../entities/loan.dart';

abstract class LoanRepository {
  Future<Loan> getLoan();
}
