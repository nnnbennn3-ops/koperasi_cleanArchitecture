import '../entities/portofolio_entity.dart';

abstract class PortofolioRepository {
  Future<PortofolioEntity> getPortofolio();
}
