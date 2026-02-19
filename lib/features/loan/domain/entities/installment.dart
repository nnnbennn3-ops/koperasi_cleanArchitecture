import 'package:equatable/equatable.dart';

class Installment extends Equatable {
  final int installmentNo;
  final String date;
  final double amount;
  final String status;

  const Installment({
    required this.installmentNo,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  List<Object?> get props => [installmentNo, date, amount, status];
}
