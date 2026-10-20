import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';

void main() {
  test('accepts a complete delivery', () {
    expect(CheckoutValidator.name('Demo Shopper'), isNull);
    expect(CheckoutValidator.phone('9876543210'), isNull);
    expect(CheckoutValidator.address('12 Market Street, 560001'), isNull);
  });

  test('rejects a short name, a landline, and an address without a PIN', () {
    expect(CheckoutValidator.name('A'), isNotNull);
    expect(CheckoutValidator.name('Demo1'), isNotNull);
    expect(CheckoutValidator.phone('1234567890'), isNotNull);
    expect(CheckoutValidator.phone('98765'), isNotNull);
    expect(CheckoutValidator.address('12 Market Street'), isNotNull);
  });

  test('accepts the demo card and a UPI id', () {
    expect(CheckoutValidator.cardNumber('4242 4242 4242 4242'), isNull);
    expect(CheckoutValidator.expiry('12/30'), isNull);
    expect(CheckoutValidator.cvv('123'), isNull);
    expect(CheckoutValidator.upi('name@bank'), isNull);
    expect(CheckoutValidator.upi('not an id'), isNotNull);
    expect(CheckoutValidator.cardNumber('1111 1111 1111 1111'), isNotNull);
  });
}
