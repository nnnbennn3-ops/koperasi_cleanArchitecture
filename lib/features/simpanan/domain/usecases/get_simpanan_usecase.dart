import '../entities/simpanan_entity.dart';
import '../repositories/simpanan_repository.dart';

class SimpananUsecase {
  final SimpananRepository repository;

  SimpananUsecase({required this.repository});

  Future<SimpananEntity> getSimpanan({required String type}) {
    return repository.getSimpanan(type: type);
  }
}
