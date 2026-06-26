import '../repositories/settings_repository.dart';

class ChangePassword {
  final SettingsRepository repository;

  ChangePassword(this.repository);

  Future<void> call({
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
