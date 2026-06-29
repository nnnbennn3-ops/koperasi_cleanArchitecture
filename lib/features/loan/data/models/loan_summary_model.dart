import '../../domain/entities/loan_summary_entity.dart';

class LoanSummaryModel extends LoanSummary {
  const LoanSummaryModel({
    required super.paidInstallment,
    required super.totalInstallment,
    required super.nextPaymentDate,
    required super.principalPaid,
    required super.totalLoan,
    required super.remainingLoan,
  });

  factory LoanSummaryModel.fromJson(Map<String, dynamic> json) {
    return LoanSummaryModel(
      paidInstallment: json['paid_installment'],
      totalInstallment: json['total_installment'],
      nextPaymentDate: json['next_payment_date'],
      principalPaid: (json['principal_paid'] as num).toDouble(),
      totalLoan: (json['total_loan'] as num).toDouble(),
      remainingLoan: (json['remaining_loan'] as num).toDouble(),
    );
  }
}
