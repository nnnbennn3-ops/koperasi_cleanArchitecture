import '../../domain/entities/form_entity.dart';
import '../../domain/repositories/form_repository.dart';
import '../datasources/form_local_datasource.dart';

class FormRepositoryImpl implements FormRepository {
  final FormLocalDataSource dataSource;

  FormRepositoryImpl(this.dataSource);

  @override
  Future<List<FormItem>> getForms() {
    return dataSource.getForms();
  }
}
