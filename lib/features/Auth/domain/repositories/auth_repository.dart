import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String identifier, String password);
  Future<User> register({
    required String memberNo,
    required String email,
    required String phone,
    required String password,
  });
}
