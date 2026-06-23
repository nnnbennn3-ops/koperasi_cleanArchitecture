import '../../../portofolio/domain/repositories/portofolio_repository.dart';

class GetPortofolio {
  final PortofolioRepository repository;

  GetPortofolio(this.repository);

  Future<Map<String, dynamic>> call() async {
    return await repository.getPortofolio();
  }
}
