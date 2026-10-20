import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/data/models/app_user.dart';
import 'package:creddinv_task/data/repositories/local_auth_repository.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';

void main() {
  test('login event does not reveal the password', () {
    const event = AuthLoginRequested(
      email: DemoCredentials.email,
      password: DemoCredentials.password,
    );
    expect(event.toString(), contains('[redacted]'));
    expect(event.toString(), isNot(contains(DemoCredentials.password)));
  });

  const repository = LocalAuthRepository(latency: Duration.zero);

  AuthBloc buildBloc() => AuthBloc(authRepository: repository);

  blocTest<AuthBloc, AuthState>(
    'signs in with the demo account',
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthLoginRequested(
        email: DemoCredentials.email,
        password: DemoCredentials.password,
      ),
    ),
    expect: () => [
      const AuthLoading(),
      const AuthAuthenticated(
        AppUser(email: DemoCredentials.email, displayName: 'Demo Shopper'),
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'rejects a wrong password',
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthLoginRequested(
        email: DemoCredentials.email,
        password: 'Wrong1234',
      ),
    ),
    expect: () => [
      const AuthLoading(),
      const AuthFailure('Invalid email or password.'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'accepts the demo email with different casing and surrounding spaces',
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthLoginRequested(
        email: '  DEMO@creddinv.com  ',
        password: DemoCredentials.password,
      ),
    ),
    expect: () => [const AuthLoading(), isA<AuthAuthenticated>()],
  );

  blocTest<AuthBloc, AuthState>(
    'logout clears the session',
    build: buildBloc,
    seed: () => const AuthAuthenticated(
      AppUser(email: DemoCredentials.email, displayName: 'Demo Shopper'),
    ),
    act: (bloc) => bloc.add(const AuthLogoutRequested()),
    expect: () => [const AuthUnauthenticated()],
  );
}
