import '../entities/simpanan.dart';

abstract class SimpananRepository {
  Future<SimpananEntity> getSimpanan({required String type});
}
