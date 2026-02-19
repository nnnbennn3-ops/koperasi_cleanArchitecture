import '../../domain/entities/form.dart';
import '../../domain/repositories/form_repository.dart';
import '../datasources/form_local_datasource.dart';

class FormRepositoryImpl implements FormRepository {
  final FormLocalDataSource dataSource;

  FormRepositoryImpl(this.dataSource);

  @override
  Future<List<FormItem>> getForms() async {
    final result = await dataSource.getForms();

    return result
        .map((e) => FormItem(title: e['title'], updatedAt: e['updatedAt']))
        .toList();
  }
}
