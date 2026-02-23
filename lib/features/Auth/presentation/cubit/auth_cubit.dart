import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login.dart';
import 'auth_state.dart';
import '../../../../core/services/secure_storage_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login loginUseCase;
  final SecureStorageService secureStorageService;

  AuthCubit(this.loginUseCase, this.secureStorageService)
    : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final user = await loginUseCase(email, password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> saveRememberMe(String email, String password) async {
    await secureStorageService.write('remember_email', email);
    await secureStorageService.write('remember_password', password);
  }

  Future<String?> getRememberedEmail() async {
    return await secureStorageService.read('remember_email');
  }

  Future<String?> getRememberedPassword() async {
    return await secureStorageService.read('remember_password');
  }

  Future<void> clearRememberedEmail() async {
    await secureStorageService.delete('remember_email');
  }

  Future<void> clearRememberedPassword() async {
    await secureStorageService.delete('remember_password');
  }

  Future<void> logout({bool clearRememberedEmail = false}) async {
    await secureStorageService.deleteToken();
    if (clearRememberedEmail) {
      await this.clearRememberedEmail();
      await this.clearRememberedPassword();
    }
    emit(AuthInitial());
  }
}
