import '../entities/form.dart';

abstract class FormRepository {
  Future<List<FormItem>> getForms();
}
