import '../entities/user_profile.dart';
import '../repositories/settings_repository.dart';

class GetProfile {
  final SettingsRepository repository;

  GetProfile(this.repository);

  Future<UserProfile> call() {
    return repository.getProfile();
  }
}
