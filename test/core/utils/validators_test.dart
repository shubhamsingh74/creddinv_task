import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/utils/validators.dart';

void main() {
  group('Validators.emailError', () {
    test('requires a value', () {
      expect(Validators.emailError('   '), 'Email is required');
    });

    test('rejects a malformed address', () {
      expect(
        Validators.emailError('ada@creddinv'),
        'Enter a valid email address',
      );
    });

    test('accepts a normal address', () {
      expect(Validators.emailError(' demo@creddinv.com '), isNull);
    });
  });

  group('Validators.passwordError', () {
    test('requires a value', () {
      expect(Validators.passwordError(''), 'Password is required');
    });

    test('requires 8 characters', () {
      expect(Validators.passwordError('Ab1'), 'Use at least 8 characters');
    });

    test('requires letters and numbers', () {
      expect(
        Validators.passwordError('longpassword'),
        'Include letters and numbers',
      );
    });

    test('accepts the demo password shape', () {
      expect(Validators.passwordError('Demo@1234'), isNull);
    });
  });
}
