import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<UserProfile> getProfile() async {
    final data = await dataSource.getProfile();
    return UserProfile(
      name: data['name'],
      memberId: data['memberId'],
      bankName: data['bankName'],
      accountNumber: data['accountNumber'],
    );
  }

  @override
  Future<void> updateBank({
    required String bank,
    required String account,
    required String name,
  }) async {
    await dataSource.updateBank();
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await dataSource.changePassword();
  }
}
