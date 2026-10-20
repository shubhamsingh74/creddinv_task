import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/data/payment_exception.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';
import 'package:creddinv_task/features/checkout/data/payment_result.dart';

/// Local card integration. The full number is checked, then only the last four
/// are kept on the receipt.
class CardPaymentGateway implements PaymentGateway {
  const CardPaymentGateway({this.latency = const Duration(milliseconds: 650)});

  final Duration latency;

  @override
  PaymentMethod get method => PaymentMethod.card;

  @override
  Future<PaymentResult> charge(PaymentRequest request) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    if (CheckoutValidator.cardNumber(request.cardNumber) != null) {
      throw const PaymentException('That card number was declined.');
    }
    if (CheckoutValidator.expiry(request.expiry) != null) {
      throw const PaymentException('Check the expiry date.');
    }
    if (CheckoutValidator.cvv(request.cvv) != null) {
      throw const PaymentException('Check the security code.');
    }

    final digits = request.cardNumber.replaceAll(RegExp(r'\D'), '');
    final last4 = digits.substring(digits.length - 4);
    return PaymentResult(
      transactionId: 'card-$last4',
      summary: 'Card •••• $last4',
    );
  }
}
