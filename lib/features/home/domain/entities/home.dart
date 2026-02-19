import 'package:equatable/equatable.dart';
import 'transaction.dart';

class HomeEntity extends Equatable {
  final double wajib;
  final double sukarela;
  final double total;
  final double deposit;
  final double withdraw;
  final List<TransactionEntity> transactions;

  const HomeEntity({
    required this.wajib,
    required this.sukarela,
    required this.total,
    required this.deposit,
    required this.withdraw,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    wajib,
    sukarela,
    total,
    deposit,
    withdraw,
    transactions,
  ];
}
