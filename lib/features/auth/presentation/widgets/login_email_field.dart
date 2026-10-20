import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/widget_keys.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/shared/widgets/app_text_field.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    required this.controller,
    required this.focusNode,
    required this.errorText,
    required this.enabled,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorText;
  final bool enabled;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      fieldKey: WidgetKeys.loginEmail,
      controller: controller,
      focusNode: focusNode,
      label: 'Email',
      hintText: 'name@email.com',
      enabled: enabled,
      errorText: errorText,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      prefixIcon: Icon(
        Icons.mail_outline,
        size: 18.r,
        color: AppColors.inkMuted,
      ),
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginEmailChanged(value));
      },
      onSubmitted: (_) => onSubmitted(),
    );
  }
}
