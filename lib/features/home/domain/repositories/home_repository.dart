import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHome({required int page});
}
