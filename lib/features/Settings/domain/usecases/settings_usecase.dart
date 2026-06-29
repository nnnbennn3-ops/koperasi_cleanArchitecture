import '../entities/user_profile_entity.dart';
import '../repositories/settings_repository.dart';

class SettingsUsecase {
  final SettingsRepository repository;

  SettingsUsecase({required this.repository});

  Future<UserProfile> getProfile() {
    return repository.getProfile();
  }

  Future<void> updateBank({
    required String bank,
    required String account,
    required String name,
  }) {
    return repository.updateBank(bank: bank, account: account, name: name);
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (newPassword != confirmPassword) {
      throw Exception('Password baru dan konfirmasinya tidak cocok');
    }
    return repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
