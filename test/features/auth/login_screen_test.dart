import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/constants/app_layout.dart';
import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/core/constants/widget_keys.dart';
import 'package:creddinv_task/core/theme/app_theme.dart';
import 'package:creddinv_task/data/repositories/local_auth_repository.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/features/auth/presentation/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpLogin(WidgetTester tester) async {
    tester.view.physicalSize = AppLayout.designSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final authBloc = AuthBloc(
      authRepository: const LocalAuthRepository(latency: Duration.zero),
    );
    addTearDown(authBloc.close);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: AppLayout.designSize,
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme.light,
            home: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: authBloc),
                BlocProvider(create: (_) => LoginBloc()),
              ],
              child: const LoginScreen(),
            ),
          );
        },
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('sign in stays disabled until the form is valid', (tester) async {
    await pumpLogin(tester);

    FilledButton button() {
      return tester.widget<FilledButton>(
        find.descendant(
          of: find.byKey(WidgetKeys.loginButton),
          matching: find.byType(FilledButton),
        ),
      );
    }

    expect(button().onPressed, isNull);

    await tester.enterText(
      find.byKey(WidgetKeys.loginEmail),
      DemoCredentials.email,
    );
    await tester.enterText(
      find.byKey(WidgetKeys.loginPassword),
      DemoCredentials.password,
    );
    await tester.pump();

    expect(button().onPressed, isNotNull);
  });

  testWidgets('shows an inline error for a bad email after unfocus', (
    tester,
  ) async {
    await pumpLogin(tester);

    await tester.enterText(find.byKey(WidgetKeys.loginEmail), 'ada');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
  });

  testWidgets('shows the repository error for a wrong password', (
    tester,
  ) async {
    await pumpLogin(tester);

    await tester.enterText(
      find.byKey(WidgetKeys.loginEmail),
      DemoCredentials.email,
    );
    await tester.enterText(find.byKey(WidgetKeys.loginPassword), 'Wrong1234');
    await tester.pump();
    await tester.ensureVisible(find.byKey(WidgetKeys.loginButton));
    await tester.tap(find.byKey(WidgetKeys.loginButton));
    await tester.pump();
    await tester.pump();

    expect(find.text('Invalid email or password.'), findsOneWidget);
  });
}
