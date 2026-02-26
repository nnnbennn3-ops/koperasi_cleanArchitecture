import '../../domain/entities/home.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_model.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.wajib,
    required super.sukarela,
    required super.total,
    required super.deposit,
    required super.withdraw,
    required super.transactions,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      wajib: (json['saldo']['wajib'] as num).toDouble(),
      sukarela: (json['saldo']['sukarela'] as num).toDouble(),
      total: (json['saldo']['total'] as num).toDouble(),
      deposit: (json['summary']['deposit'] as num).toDouble(),
      withdraw: (json['summary']['withdraw'] as num).toDouble(),
      transactions:
          (json['transactions'] as List)
              .map((e) => TransactionModel.fromJson(e))
              .toList(),
    );
  }

  HomeModel copyWith({
    double? wajib,
    double? sukarela,
    double? total,
    double? deposit,
    double? withdraw,
    List<TransactionEntity>? transactions,
  }) {
    return HomeModel(
      wajib: wajib ?? this.wajib,
      sukarela: sukarela ?? this.sukarela,
      total: total ?? this.total,
      deposit: deposit ?? this.deposit,
      withdraw: withdraw ?? this.withdraw,
      transactions: transactions ?? this.transactions,
    );
  }
}
