import 'package:equatable/equatable.dart';
import '../../domain/entities/form_entity.dart';

abstract class FormulirState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormulirInitial extends FormulirState {}

class FormulirLoading extends FormulirState {}

class FormulirLoaded extends FormulirState {
  final List<FormItem> forms;
  FormulirLoaded(this.forms);

  @override
  List<Object?> get props => [forms];
}

class FormulirError extends FormulirState {
  final String message;
  FormulirError(this.message);

  @override
  List<Object?> get props => [message];
}
