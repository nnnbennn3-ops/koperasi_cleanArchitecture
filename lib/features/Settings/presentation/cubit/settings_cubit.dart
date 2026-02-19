import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetProfile getProfile;

  SettingsCubit(this.getProfile) : super(SettingsInitial());

  void fetchProfile() async {
    try {
      emit(SettingsLoading());
      final profile = await getProfile();

      emit(SettingsLoaded(profile));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
