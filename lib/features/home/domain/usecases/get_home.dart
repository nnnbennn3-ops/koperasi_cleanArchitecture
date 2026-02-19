import '../entities/home.dart';
import '../repositories/home_repository.dart';

class GetHome {
  final HomeRepository repository;

  GetHome(this.repository);

  Future<HomeEntity> call({required int page}) {
    return repository.getHome(page: page);
  }
}
