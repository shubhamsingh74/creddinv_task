import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/data/exceptions/auth_exception.dart';
import 'package:creddinv_task/data/models/app_user.dart';
import 'package:creddinv_task/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Session bloc. The router redirects from this state.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthUnauthenticated()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthLoading) return;

    emit(const AuthLoading());
    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user));
    } on AuthException catch (error) {
      emit(AuthFailure(error.message));
    } on Object {
      emit(const AuthFailure(AppStrings.unexpectedError));
    }
  }

  void _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) {
    emit(const AuthUnauthenticated());
  }
}
