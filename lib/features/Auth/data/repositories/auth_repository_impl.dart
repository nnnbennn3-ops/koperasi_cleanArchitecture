import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../../../../core/services/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource dataSource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl(this.dataSource, this.secureStorage);

  @override
  Future<User> login(String email, String password) async {
    final users = await dataSource.getUsers();

    try {
      final user = users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      await secureStorage.saveToken("dummy_token_${user.id}");
      return user;
    } catch (_) {
      throw Exception("Email atau password salah");
    }
  }
}
