import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Log out',
      onPressed: () {
        context.read<AuthBloc>().add(const AuthLogoutRequested());
      },
      icon: const Icon(Icons.logout),
    );
  }
}
