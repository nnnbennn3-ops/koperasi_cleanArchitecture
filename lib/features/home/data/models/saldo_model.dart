import '../../domain/entities/saldo.dart';

class SaldoModel extends Saldo {
  const SaldoModel({
    required super.wajib,
    required super.sukarela,
    required super.total,
  });

  factory SaldoModel.fromJson(Map<String, dynamic> json) {
    return SaldoModel(
      wajib: (json['wajib'] as num).toDouble(),
      sukarela: (json['sukarela'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
