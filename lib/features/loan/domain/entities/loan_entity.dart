import 'package:equatable/equatable.dart';
import 'loan_summary_entity.dart';
import 'installment_entity.dart';

class Loan extends Equatable {
  final String id;
  final LoanSummary summary;
  final List<Installment> installments;

  const Loan({
    required this.id,
    required this.summary,
    required this.installments,
  });

  @override
  List<Object?> get props => [id, summary, installments];
}
