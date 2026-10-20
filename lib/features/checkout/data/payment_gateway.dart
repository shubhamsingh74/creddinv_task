import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';
import 'package:creddinv_task/features/checkout/data/payment_result.dart';

/// One payment integration. Checkout talks to this, not to a specific provider.
abstract interface class PaymentGateway {
  PaymentMethod get method;

  Future<PaymentResult> charge(PaymentRequest request);
}
