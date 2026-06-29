import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String type;
  final String title;
  final DateTime date;
  final double amount;

  const TransactionEntity({
    required this.type,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [type, title, date, amount];
}
