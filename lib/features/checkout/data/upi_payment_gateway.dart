import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/data/payment_exception.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';
import 'package:creddinv_task/features/checkout/data/payment_result.dart';

/// Local UPI integration. A real app would hand this id to a UPI intent.
class UpiPaymentGateway implements PaymentGateway {
  const UpiPaymentGateway({this.latency = const Duration(milliseconds: 650)});

  final Duration latency;

  @override
  PaymentMethod get method => PaymentMethod.upi;

  @override
  Future<PaymentResult> charge(PaymentRequest request) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    final id = request.upiId.trim();
    if (CheckoutValidator.upi(id) != null) {
      throw const PaymentException('That UPI id was not accepted.');
    }
    return PaymentResult(transactionId: 'upi', summary: id);
  }
}
