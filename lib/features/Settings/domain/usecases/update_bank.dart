import '../repositories/settings_repository.dart';

class UpdateBank {
  final SettingsRepository repository;

  UpdateBank(this.repository);

  Future<void> call({
    required String bank,
    required String account,
    required String name,
  }) {
    return repository.updateBank(bank: bank, account: account, name: name);
  }
}
