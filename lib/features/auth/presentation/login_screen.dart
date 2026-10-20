import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/login_form.dart';
import 'package:creddinv_task/shared/widgets/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onEmailFocus);
    _passwordFocus.addListener(_onPasswordFocus);
  }

  @override
  void dispose() {
    _emailFocus.removeListener(_onEmailFocus);
    _passwordFocus.removeListener(_onPasswordFocus);
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailFocus() {
    if (!mounted || _emailFocus.hasFocus) return;
    context.read<LoginBloc>().add(const LoginEmailUnfocused());
  }

  void _onPasswordFocus() {
    if (!mounted || _passwordFocus.hasFocus) return;
    context.read<LoginBloc>().add(const LoginPasswordUnfocused());
  }

  void _fillDemoAccount() {
    _emailController.text = DemoCredentials.email;
    _passwordController.text = DemoCredentials.password;
    context.read<LoginBloc>()
      ..add(const LoginEmailChanged(DemoCredentials.email))
      ..add(const LoginPasswordChanged(DemoCredentials.password))
      ..add(const LoginEmailUnfocused())
      ..add(const LoginPasswordUnfocused());
  }

  void _submit() {
    final login = context.read<LoginBloc>().state;
    context.read<AuthBloc>().add(
      AuthLoginRequested(email: login.email, password: login.password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthAuthenticated,
      listener: (context, state) => _passwordController.clear(),
      child: AppScaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: LoginForm(
              emailController: _emailController,
              passwordController: _passwordController,
              emailFocus: _emailFocus,
              passwordFocus: _passwordFocus,
              onFillDemo: _fillDemoAccount,
              onSubmit: _submit,
            ),
          ),
        ),
      ),
    );
  }
}
