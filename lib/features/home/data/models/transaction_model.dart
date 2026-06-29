import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.type,
    required super.title,
    required super.date,
    required super.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      type: json['type'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
