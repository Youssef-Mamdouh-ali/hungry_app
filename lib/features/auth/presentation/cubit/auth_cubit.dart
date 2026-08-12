import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:hungry_app/features/auth/domain/use_cases/get_current_user_use_case.dart';

import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,

  }) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await logoutUseCase();

      emit(AuthLogoutSuccess());
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    try {
      final user = await getCurrentUserUseCase();

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }
}