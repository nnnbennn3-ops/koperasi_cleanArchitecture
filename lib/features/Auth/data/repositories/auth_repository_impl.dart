import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';
import '../../../../core/services/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource dataSource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl(this.dataSource, this.secureStorage);

  @override
  Future<User> login(String identifier, String password) async {
    final userData = await dataSource.login(identifier, password);
    final user = UserModel.fromJson(userData);
    await secureStorage.saveToken('dummy_token_${user.id}');
    return user;
  }

  @override
  Future<User> register({
    required String memberNo,
    required String email,
    required String phone,
    required String password,
  }) async {
    final userData = await dataSource.register(
      memberNo: memberNo,
      email: email,
      phone: phone,
      password: password,
    );
    final user = UserModel.fromJson(userData);
    await secureStorage.saveToken('dummy_token_${user.id}');
    return user;
  }
}
