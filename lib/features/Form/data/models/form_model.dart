import '../../domain/entities/form_entity.dart';

class FormItemModel extends FormItem {
  const FormItemModel({required super.title, required super.updatedAt});

  factory FormItemModel.fromJson(Map<String, dynamic> json) {
    return FormItemModel(
      title: json['title'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
