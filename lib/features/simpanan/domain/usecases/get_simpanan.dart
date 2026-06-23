import '../entities/simpanan.dart';
import '../repositories/simpanan_repository.dart';

class GetSimpanan {
  final SimpananRepository repository;

  GetSimpanan(this.repository);

  Future<SimpananEntity> call({required String type}) {
    return repository.getSimpanan(type: type);
  }
}
