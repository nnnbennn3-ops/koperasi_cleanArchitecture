import 'package:equatable/equatable.dart';

class PortofolioItemEntity extends Equatable {
  final String title;
  final double total;
  final String type;

  const PortofolioItemEntity({
    required this.title,
    required this.total,
    required this.type,
  });

  @override
  List<Object?> get props => [title, total, type];
}
