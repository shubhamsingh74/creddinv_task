import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/data/exceptions/auth_exception.dart';
import 'package:creddinv_task/data/models/app_user.dart';
import 'package:creddinv_task/data/repositories/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository({this.latency = const Duration(milliseconds: 450)});

  final Duration latency;

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    if (latency > Duration.zero) {
      await Future<void>.delayed(latency);
    }

    final emailMatches = email.trim().toLowerCase() == DemoCredentials.email;
    final passwordMatches = password == DemoCredentials.password;
    if (!emailMatches || !passwordMatches) {
      throw const AuthException(AppStrings.invalidCredentials);
    }

    return const AppUser(
      email: DemoCredentials.email,
      displayName: 'Demo Shopper',
    );
  }
}
