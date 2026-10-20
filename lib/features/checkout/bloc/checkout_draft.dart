import 'package:equatable/equatable.dart';

import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';

class CheckoutDraft extends Equatable {
  const CheckoutDraft({
    this.name = '',
    this.phone = '',
    this.address = '',
    this.method = PaymentMethod.card,
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
    this.upiId = '',
  });

  final String name;
  final String phone;
  final String address;
  final PaymentMethod method;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final String upiId;

  bool get detailsValid =>
      CheckoutValidator.name(name) == null &&
      CheckoutValidator.phone(phone) == null &&
      CheckoutValidator.address(address) == null;

  bool get paymentValid => switch (method) {
    PaymentMethod.card =>
      CheckoutValidator.cardNumber(cardNumber) == null &&
          CheckoutValidator.expiry(expiry) == null &&
          CheckoutValidator.cvv(cvv) == null,
    PaymentMethod.upi => CheckoutValidator.upi(upiId) == null,
    PaymentMethod.cashOnDelivery => true,
  };

  CheckoutDraft copyWith({
    String? name,
    String? phone,
    String? address,
    PaymentMethod? method,
    String? cardNumber,
    String? expiry,
    String? cvv,
    String? upiId,
  }) {
    return CheckoutDraft(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      method: method ?? this.method,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvv: cvv ?? this.cvv,
      upiId: upiId ?? this.upiId,
    );
  }

  @override
  List<Object?> get props => [
    name,
    phone,
    address,
    method,
    cardNumber,
    expiry,
    cvv,
    upiId,
  ];

  @override
  String toString() {
    return 'CheckoutDraft(name: $name, phone: $phone, method: $method, '
        'card: [redacted], cvv: [redacted], upiId: $upiId)';
  }
}
