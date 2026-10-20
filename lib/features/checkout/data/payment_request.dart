import 'package:equatable/equatable.dart';

class PaymentRequest extends Equatable {
  const PaymentRequest({
    required this.amountInCents,
    required this.orderId,
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
    this.upiId = '',
  });

  final int amountInCents;
  final String orderId;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final String upiId;

  @override
  List<Object?> get props => [
    amountInCents,
    orderId,
    cardNumber,
    expiry,
    cvv,
    upiId,
  ];

  @override
  String toString() {
    return 'PaymentRequest(amountInCents: $amountInCents, orderId: $orderId, '
        'card: [redacted], cvv: [redacted], upiId: $upiId)';
  }
}
