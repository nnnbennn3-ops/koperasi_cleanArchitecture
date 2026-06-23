import '../../domain/repositories/portofolio_repository.dart';
import '../datasource/portofolio_local_datasource.dart';

class PortofolioRepositoryImpl implements PortofolioRepository {
  final PortofolioLocalDataSource dataSource;

  PortofolioRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getPortofolio() {
    return dataSource.getPortofolio();
  }
}
