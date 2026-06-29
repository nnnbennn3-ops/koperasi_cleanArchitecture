import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class HomeUsecase {
  final HomeRepository repository;

  HomeUsecase({required this.repository});

  Future<HomeEntity> getHome({required int page}) {
    return repository.getHome(page: page);
  }
}
