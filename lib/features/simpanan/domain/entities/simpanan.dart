import 'package:equatable/equatable.dart';

class SimpananTransactionEntity extends Equatable {
  final String title;
  final DateTime date;
  final double amount;
  final bool isCredit;

  const SimpananTransactionEntity({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });

  @override
  List<Object?> get props => [title, date, amount, isCredit];
}

class SimpananEntity extends Equatable {
  final String type;
  final double balance;
  final double totalOutgoing;
  final double totalIncoming;
  final List<SimpananTransactionEntity> transactions;

  const SimpananEntity({
    required this.type,
    required this.balance,
    required this.totalOutgoing,
    required this.totalIncoming,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    type,
    balance,
    totalOutgoing,
    totalIncoming,
    transactions,
  ];
}
