import 'package:equatable/equatable.dart';

class LoanSummary extends Equatable {
  final int paidInstallment;
  final int totalInstallment;
  final String nextPaymentDate;
  final double principalPaid;
  final double totalLoan;
  final double remainingLoan;

  const LoanSummary({
    required this.paidInstallment,
    required this.totalInstallment,
    required this.nextPaymentDate,
    required this.principalPaid,
    required this.totalLoan,
    required this.remainingLoan,
  });

  @override
  List<Object?> get props => [
    paidInstallment,
    totalInstallment,
    nextPaymentDate,
    principalPaid,
    totalLoan,
    remainingLoan,
  ];
}
