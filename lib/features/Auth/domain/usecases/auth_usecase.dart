import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;

  AuthUsecase({required this.repository});

  Future<User> login(String identifier, String password) {
    return repository.login(identifier, password);
  }

  Future<User> register({
    required String memberNo,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.register(
      memberNo: memberNo,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
