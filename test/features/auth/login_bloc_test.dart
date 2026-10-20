import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';

void main() {
  test('login state does not reveal the password', () {
    const state = LoginState(email: 'ada@creddinv.com', password: 'Demo@1234');
    expect(state.toString(), contains('[redacted]'));
    expect(state.toString(), isNot(contains('Demo@1234')));
  });

  blocTest<LoginBloc, LoginState>(
    'keeps submit disabled until both fields are valid',
    build: LoginBloc.new,
    act: (bloc) {
      bloc
        ..add(const LoginEmailChanged('demo@creddinv.com'))
        ..add(const LoginPasswordChanged('short1'));
    },
    verify: (bloc) => expect(bloc.state.canSubmit, isFalse),
  );

  blocTest<LoginBloc, LoginState>(
    'enables submit for a valid email and password',
    build: LoginBloc.new,
    act: (bloc) {
      bloc
        ..add(const LoginEmailChanged(DemoCredentials.email))
        ..add(const LoginPasswordChanged(DemoCredentials.password));
    },
    verify: (bloc) => expect(bloc.state.canSubmit, isTrue),
  );

  blocTest<LoginBloc, LoginState>(
    'shows the email error only after the field is left',
    build: LoginBloc.new,
    act: (bloc) => bloc.add(const LoginEmailChanged('not-an-email')),
    verify: (bloc) => expect(bloc.state.emailErrorText, isNull),
  );

  blocTest<LoginBloc, LoginState>(
    'reports an invalid email once the field loses focus',
    build: LoginBloc.new,
    act: (bloc) {
      bloc
        ..add(const LoginEmailChanged('not-an-email'))
        ..add(const LoginEmailUnfocused());
    },
    verify: (bloc) {
      expect(bloc.state.emailErrorText, 'Enter a valid email address');
    },
  );

  blocTest<LoginBloc, LoginState>(
    'toggles password visibility',
    build: LoginBloc.new,
    act: (bloc) => bloc.add(const LoginPasswordVisibilityToggled()),
    expect: () => [const LoginState(obscurePassword: false)],
  );
}
