import 'package:creddinv_task/core/constants/app_strings.dart';

/// Pure checks for the login form. The login button stays disabled until
/// both [emailError] and [passwordError] return null.
abstract final class Validators {
  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  static final RegExp _hasLetter = RegExp(r'[A-Za-z]');
  static final RegExp _hasDigit = RegExp(r'\d');

  static String? emailError(String value) {
    final email = value.trim();
    if (email.isEmpty) return AppStrings.emailRequired;
    if (!_emailPattern.hasMatch(email)) return AppStrings.emailInvalid;
    return null;
  }

  static String? passwordError(String value) {
    if (value.isEmpty) return AppStrings.passwordRequired;
    if (value.length < 8) return AppStrings.passwordTooShort;
    if (!_hasLetter.hasMatch(value) || !_hasDigit.hasMatch(value)) {
      return AppStrings.passwordNeedsMix;
    }
    return null;
  }
}
