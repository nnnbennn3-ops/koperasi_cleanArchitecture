import '../entities/form.dart';
import '../repositories/form_repository.dart';

class GetForms {
  final FormRepository repository;

  GetForms(this.repository);

  Future<List<FormItem>> call() {
    return repository.getForms();
  }
}
