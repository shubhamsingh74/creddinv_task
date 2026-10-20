import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/widget_keys.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/demo_account_card.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/login_hero.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/login_email_field.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/login_password_field.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.onFillDemo,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final VoidCallback onFillDemo;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, login) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, auth) {
            final isLoading = auth is AuthLoading;
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHero(),
                  Transform.translate(
                    offset: Offset(0, -36.h),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 28.h),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 24,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                          child: AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Welcome back',
                                  style: AppTextStyles.headline,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Sign in to browse the shop and keep a cart.',
                                  style: AppTextStyles.body,
                                ),
                                SizedBox(height: 24.h),
                                LoginEmailField(
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  errorText: login.emailErrorText,
                                  enabled: !isLoading,
                                  onSubmitted: passwordFocus.requestFocus,
                                ),
                                SizedBox(height: 16.h),
                                LoginPasswordField(
                                  controller: passwordController,
                                  focusNode: passwordFocus,
                                  login: login,
                                  enabled: !isLoading,
                                  onSubmitted: () {
                                    if (login.canSubmit && !isLoading) {
                                      onSubmit();
                                    }
                                  },
                                ),
                                if (auth is AuthFailure) ...[
                                  SizedBox(height: 16.h),
                                  AuthErrorBanner(message: auth.message),
                                ],
                                SizedBox(height: 22.h),
                                PrimaryButton(
                                  key: WidgetKeys.loginButton,
                                  label: 'Sign in',
                                  isLoading: isLoading,
                                  onPressed: login.canSubmit && !isLoading
                                      ? onSubmit
                                      : null,
                                ),
                                SizedBox(height: 24.h),
                                DemoAccountCard(onFill: onFillDemo),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
