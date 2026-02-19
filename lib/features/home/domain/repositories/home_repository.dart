import '../entities/home.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHome({required int page});
}
