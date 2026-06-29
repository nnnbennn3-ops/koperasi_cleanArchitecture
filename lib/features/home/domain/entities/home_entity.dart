import 'package:equatable/equatable.dart';
import 'transaction_entity.dart';

class HomeEntity extends Equatable {
  final String userName;
  final String memberId;
  final double wajib;
  final double sukarela;
  final double total;
  final double deposit;
  final double withdraw;
  final List<TransactionEntity> transactions;

  const HomeEntity({
    required this.userName,
    required this.memberId,
    required this.wajib,
    required this.sukarela,
    required this.total,
    required this.deposit,
    required this.withdraw,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    userName,
    memberId,
    wajib,
    sukarela,
    total,
    deposit,
    withdraw,
    transactions,
  ];
}
