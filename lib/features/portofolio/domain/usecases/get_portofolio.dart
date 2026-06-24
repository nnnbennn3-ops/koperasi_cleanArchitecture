import '../entities/portofolio.dart';
import '../repositories/portofolio_repository.dart';

class GetPortofolio {
  final PortofolioRepository repository;

  GetPortofolio(this.repository);

  Future<PortofolioEntity> call() {
    return repository.getPortofolio();
  }
}
