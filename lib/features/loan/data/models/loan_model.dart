import '../../domain/entities/loan.dart';
import 'loan_summary_model.dart';
import 'installment_model.dart';

class LoanModel extends Loan {
  const LoanModel({
    required super.id,
    required super.summary,
    required super.installments,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      summary: LoanSummaryModel.fromJson(json['summary']),
      installments:
          (json['installments'] as List)
              .map((e) => InstallmentModel.fromJson(e))
              .toList(),
    );
  }
}
