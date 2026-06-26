import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_bank.dart';
import '../../domain/usecases/change_password.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetProfile getProfile;
  final UpdateBank updateBank;
  final ChangePassword changePassword;

  SettingsCubit({
    required this.getProfile,
    required this.updateBank,
    required this.changePassword,
  }) : super(SettingsInitial());

  Future<void> fetchProfile() async {
    try {
      emit(SettingsLoading());
      final profile = await getProfile();
      emit(SettingsLoaded(profile));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> saveBank({
    required String bank,
    required String account,
    required String name,
  }) async {
    try {
      emit(SettingsUpdateLoading());
      await updateBank(bank: bank, account: account, name: name);
      emit(SettingsUpdateSuccess('Rekeing bank berhasil disimpan'));
      final profile = await getProfile();
      emit(SettingsLoaded(profile));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> doChangePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(SettingsUpdateLoading());
      await changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(SettingsUpdateSuccess('Password berhasil diubah'));
      final profile = await getProfile();
      emit(SettingsLoaded(profile));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
