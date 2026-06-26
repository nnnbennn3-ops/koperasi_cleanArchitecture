import 'package:equatable/equatable.dart';

class FormItem extends Equatable {
  final String title;
  final String updatedAt;

  const FormItem({required this.title, required this.updatedAt});

  @override
  List<Object?> get props => [title, updatedAt];
}
