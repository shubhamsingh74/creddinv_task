import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/utils/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Owns the login form. The session lives in AuthBloc.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEmailUnfocused>(_onEmailUnfocused);
    on<LoginPasswordUnfocused>(_onPasswordUnfocused);
    on<LoginPasswordVisibilityToggled>(_onVisibilityToggled);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onEmailUnfocused(LoginEmailUnfocused event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailTouched: true));
  }

  void _onPasswordUnfocused(
    LoginPasswordUnfocused event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(passwordTouched: true));
  }

  void _onVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}
