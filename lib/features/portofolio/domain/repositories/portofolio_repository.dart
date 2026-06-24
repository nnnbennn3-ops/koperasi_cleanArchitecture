import '../entities/portofolio.dart';

abstract class PortofolioRepository {
  Future<PortofolioEntity> getPortofolio();
}
