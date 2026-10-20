part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.emailTouched = false,
    this.passwordTouched = false,
  });

  final String email;
  final String password;
  final bool obscurePassword;
  final bool emailTouched;
  final bool passwordTouched;

  bool get canSubmit =>
      Validators.emailError(email) == null &&
      Validators.passwordError(password) == null;

  String? get emailErrorText =>
      emailTouched ? Validators.emailError(email) : null;

  String? get passwordErrorText =>
      passwordTouched ? Validators.passwordError(password) : null;

  LoginState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    bool? emailTouched,
    bool? passwordTouched,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      emailTouched: emailTouched ?? this.emailTouched,
      passwordTouched: passwordTouched ?? this.passwordTouched,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    obscurePassword,
    emailTouched,
    passwordTouched,
  ];

  /// Password stays in state for submit, and out of logs and bloc dumps.
  @override
  String toString() {
    return 'LoginState(email: $email, password: [redacted], '
        'obscurePassword: $obscurePassword, emailTouched: $emailTouched, '
        'passwordTouched: $passwordTouched)';
  }
}
