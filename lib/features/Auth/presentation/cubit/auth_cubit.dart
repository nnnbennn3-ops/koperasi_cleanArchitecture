import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import 'auth_state.dart';
import '../../../../core/services/secure_storage_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login loginUseCase;
  final Register registerUseCase;
  final SecureStorageService secureStorageService;

  AuthCubit(this.loginUseCase, this.registerUseCase, this.secureStorageService)
    : super(AuthInitial());

  Future<void> login(String identifier, String password) async {
    try {
      emit(AuthLoading());
      final user = await loginUseCase(identifier, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> register({
    required String memberNo,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(AuthFailure('Password dan konfirmasi password tidak cocok'));
      return;
    }
    if (memberNo.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      emit(AuthFailure('Semua field harus diisi'));
      return;
    }

    try {
      emit(AuthLoading());
      final user = await registerUseCase(
        memberNo: memberNo,
        email: email,
        phone: phone,
        password: password,
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
