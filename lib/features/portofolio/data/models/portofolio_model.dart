import '../../domain/entities/portofolio_entity.dart';
import '../../domain/entities/portofolio_item_entity.dart';

class PortofolioItemModel extends PortofolioItemEntity {
  const PortofolioItemModel({
    required super.title,
    required super.total,
    required super.type,
  });

  factory PortofolioItemModel.fromJson(Map<String, dynamic> json) {
    return PortofolioItemModel(
      title: json['title'] as String,
      total: (json['total'] as num).toDouble(),
      type: json['type'] as String,
    );
  }
}

class PortofolioModel extends PortofolioEntity {
  const PortofolioModel({required super.totalSaldo, required super.items});

  factory PortofolioModel.fromJson(Map<String, dynamic> json) {
    return PortofolioModel(
      totalSaldo: (json['total_saldo'] as num).toDouble(),
      items:
          (json['items'] as List)
              .map(
                (e) => PortofolioItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
