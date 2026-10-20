enum PaymentMethod { card, upi, cashOnDelivery }

extension PaymentMethodLabel on PaymentMethod {
  String get label => switch (this) {
    PaymentMethod.card => 'Card',
    PaymentMethod.upi => 'UPI',
    PaymentMethod.cashOnDelivery => 'Cash on delivery',
  };
}
