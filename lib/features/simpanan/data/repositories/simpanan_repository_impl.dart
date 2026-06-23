import '../../domain/entities/simpanan.dart';
import '../../domain/repositories/simpanan_repository.dart';
import '../datasource/simpanan_local_datasource.dart';

class SimpananRepositoryImpl implements SimpananRepository {
  final SimpananLocalDataSource dataSource;

  SimpananRepositoryImpl(this.dataSource);

  @override
  Future<SimpananEntity> getSimpanan({required String type}) {
    return dataSource.getSimpanan(type: type);
  }
}
