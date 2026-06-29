import '../entities/form_entity.dart';
import '../repositories/form_repository.dart';

class FormUsecase {
  final FormRepository repository;

  FormUsecase({required this.repository});

  Future<List<FormItem>> getForms() {
    return repository.getForms();
  }
}
