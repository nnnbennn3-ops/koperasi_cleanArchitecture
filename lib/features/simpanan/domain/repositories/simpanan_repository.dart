import '../entities/simpanan_entity.dart';

abstract class SimpananRepository {
  Future<SimpananEntity> getSimpanan({required String type});
}
