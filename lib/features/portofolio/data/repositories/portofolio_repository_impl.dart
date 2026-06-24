import '../../domain/entities/portofolio.dart';
import '../../domain/repositories/portofolio_repository.dart';
import '../datasource/portofolio_local_datasource.dart';

class PortofolioRepositoryImpl implements PortofolioRepository {
  final PortofolioLocalDataSource dataSource;

  PortofolioRepositoryImpl(this.dataSource);

  @override
  Future<PortofolioEntity> getPortofolio() {
    return dataSource.getPortofolio();
  }
}
