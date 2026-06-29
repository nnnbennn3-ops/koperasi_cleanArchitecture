import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/settings_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsUsecase usecase;

  SettingsCubit(this.usecase) : super(SettingsInitial());

  Future<void> fetchProfile() async {
    try {
      emit(SettingsLoading());
      final profile = await usecase.getProfile();
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
      await usecase.updateBank(bank: bank, account: account, name: name);
      emit(SettingsUpdateSuccess('Rekening bank berhasil disimpan'));
      final profile = await usecase.getProfile();
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
      await usecase.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(SettingsUpdateSuccess('Password berhasil diubah'));
      final profile = await usecase.getProfile();
      emit(SettingsLoaded(profile));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
