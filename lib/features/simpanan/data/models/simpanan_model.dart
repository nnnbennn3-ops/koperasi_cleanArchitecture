import '../../domain/entities/simpanan_entity.dart';

class SimpananTransactionModel extends SimpananTransactionEntity {
  const SimpananTransactionModel({
    required super.title,
    required super.date,
    required super.amount,
    required super.isCredit,
  });

  factory SimpananTransactionModel.fromJson(Map<String, dynamic> json) {
    return SimpananTransactionModel(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      isCredit: json['is_credit'] as bool,
    );
  }
}

class SimpananModel extends SimpananEntity {
  const SimpananModel({
    required super.type,
    required super.balance,
    required super.totalOutgoing,
    required super.totalIncoming,
    required super.transactions,
  });

  factory SimpananModel.fromJson(Map<String, dynamic> json) {
    return SimpananModel(
      type: json['type'] as String,
      balance: (json['balance'] as num).toDouble(),
      totalOutgoing: (json['total_outgoing'] as num).toDouble(),
      totalIncoming: (json['total_incoming'] as num).toDouble(),
      transactions:
          (json['transactions'] as List)
              .map((e) => SimpananTransactionModel.fromJson(e))
              .toList(),
    );
  }
}
