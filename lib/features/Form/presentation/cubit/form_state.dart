import '../../domain/entities/form.dart';

abstract class FormStatus {}

class FormInitial extends FormStatus {}

class FormLoading extends FormStatus {}

class FormLoaded extends FormStatus {
  final List<FormItem> forms;
  FormLoaded(this.forms);
}

class FormError extends FormStatus {
  final String message;
  FormError(this.message);
}
