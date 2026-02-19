import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final user = await loginUseCase(email, password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
