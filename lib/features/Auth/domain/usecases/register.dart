import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<User> call({
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
