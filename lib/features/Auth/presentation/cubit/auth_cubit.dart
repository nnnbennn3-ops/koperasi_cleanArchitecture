import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../data/models/register_model.dart';
import 'auth_state.dart';
import '../../../../core/services/secure_storage_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase usecase;
  final SecureStorageService secureStorageService;

  AuthCubit(this.usecase, this.secureStorageService) : super(AuthInitial());

  Future<void> login(String identifier, String password) async {
    try {
      emit(AuthLoading());
      final user = await usecase.login(identifier, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> register(RegisterModel request) async {
    //Validasi
    if (request.memberNo.isEmpty ||
        request.email.isEmpty ||
        request.phone.isEmpty ||
        request.password.isEmpty) {
      emit(AuthFailure('Semua field harus diisi'));
      return;
    }
    if (request.password != request.confirmPassword) {
      emit(AuthFailure('Password dan konfirmasi password tidak cocok'));
      return;
    }

    try {
      emit(AuthLoading());
      final user = await usecase.register(
        memberNo: request.memberNo,
        email: request.email,
        phone: request.phone,
        password: request.password,
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  // ---- Remember Me ----
  Future<void> saveRememberMe(String identifier, String password) async {
    await secureStorageService.write('remember_identifier', identifier);
    await secureStorageService.write('remember_password', password);
  }

  Future<String?> getRememberedIdentifier() async {
    return await secureStorageService.read('remember_identifier');
  }

  Future<String?> getRememberedPassword() async {
    return await secureStorageService.read('remember_password');
  }

  Future<void> clearRememberedCredentials() async {
    await secureStorageService.delete('remember_identifier');
    await secureStorageService.delete('remember_password');
  }

  // ---- Logout ----
  Future<void> logout({bool clearRemembered = false}) async {
    await secureStorageService.deleteToken();
    if (clearRemembered) {
      await clearRememberedCredentials();
    }
    emit(AuthInitial());
  }
}
