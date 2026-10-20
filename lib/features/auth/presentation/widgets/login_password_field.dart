import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/widget_keys.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/shared/widgets/app_text_field.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    required this.controller,
    required this.focusNode,
    required this.login,
    required this.enabled,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final LoginState login;
  final bool enabled;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      fieldKey: WidgetKeys.loginPassword,
      controller: controller,
      focusNode: focusNode,
      label: 'Password',
      hintText: 'Enter your password',
      enabled: enabled,
      obscureText: login.obscurePassword,
      errorText: login.passwordErrorText,
      helperText: login.passwordErrorText == null
          ? 'At least 8 characters, with letters and numbers.'
          : null,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      prefixIcon: Icon(
        Icons.lock_outline,
        size: 18.r,
        color: AppColors.inkMuted,
      ),
      suffixIcon: IconButton(
        tooltip: login.obscurePassword ? 'Show password' : 'Hide password',
        onPressed: enabled
            ? () {
                context.read<LoginBloc>().add(
                  const LoginPasswordVisibilityToggled(),
                );
              }
            : null,
        icon: Icon(
          login.obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginPasswordChanged(value));
      },
      onSubmitted: (_) => onSubmitted(),
    );
  }
}
