import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../model/user_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<UserProfile> getProfile() async {
    final data = await dataSource.getProfile();
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<void> updateBank({
    required String bank,
    required String account,
    required String name,
  }) async {
    await dataSource.updateBank(bank: bank, account: account, name: name);
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await dataSource.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
