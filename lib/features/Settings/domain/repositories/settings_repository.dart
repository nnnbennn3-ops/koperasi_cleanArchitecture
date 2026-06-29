import '../entities/user_profile_entity.dart';

abstract class SettingsRepository {
  Future<UserProfile> getProfile();
  Future<void> updateBank({
    required String bank,
    required String account,
    required String name,
  });
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
