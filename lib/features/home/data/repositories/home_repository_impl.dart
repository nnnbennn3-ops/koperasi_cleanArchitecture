import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  @override
  Future<HomeEntity> getHome({required int page}) {
    return dataSource.getHome(page: page);
  }
}
