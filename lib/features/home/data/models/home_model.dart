import '../../domain/entities/home.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_model.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.userName,
    required super.memberId,
    required super.wajib,
    required super.sukarela,
    required super.total,
    required super.deposit,
    required super.withdraw,
    required super.transactions,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      userName: json['user']['name'] as String,
      memberId: json['user']['member_id'] as String,
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
    String? userName,
    String? memberId,
    double? wajib,
    double? sukarela,
    double? total,
    double? deposit,
    double? withdraw,
    List<TransactionEntity>? transactions,
  }) {
    return HomeModel(
      userName: userName ?? this.userName,
      memberId: memberId ?? this.memberId,
      wajib: wajib ?? this.wajib,
      sukarela: sukarela ?? this.sukarela,
      total: total ?? this.total,
      deposit: deposit ?? this.deposit,
      withdraw: withdraw ?? this.withdraw,
      transactions: transactions ?? this.transactions,
    );
  }
}
