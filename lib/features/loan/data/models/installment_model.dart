import '../../domain/entities/installment.dart';

class InstallmentModel extends Installment {
  const InstallmentModel({
    required super.installmentNo,
    required super.date,
    required super.amount,
    required super.status,
  });

  factory InstallmentModel.fromJson(Map<String, dynamic> json) {
    return InstallmentModel(
      installmentNo: json['installment_no'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
    );
  }
}
