import 'package:equatable/equatable.dart';
import 'portofolio_item_entity.dart';

class PortofolioEntity extends Equatable {
  final double totalSaldo;
  final List<PortofolioItemEntity> items;

  const PortofolioEntity({required this.totalSaldo, required this.items});

  @override
  List<Object?> get props => [totalSaldo, items];
}
