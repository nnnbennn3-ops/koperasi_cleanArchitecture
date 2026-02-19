import '../../domain/entities/home.dart';
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

  HomeModel copyWith({List<TransactionModel>? transactions}) {
    return HomeModel(
      total: total,
      wajib: wajib,
      sukarela: sukarela,
      deposit: deposit,
      withdraw: withdraw,
      transactions: transactions ?? this.transactions,
    );
  }
}
