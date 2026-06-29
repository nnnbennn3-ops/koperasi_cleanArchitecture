import '../entities/portofolio_entity.dart';
import '../repositories/portofolio_repository.dart';

class PortofolioUsecase {
  final PortofolioRepository repository;

  PortofolioUsecase({required this.repository});

  Future<PortofolioEntity> getPortofolio() {
    return repository.getPortofolio();
  }
}
