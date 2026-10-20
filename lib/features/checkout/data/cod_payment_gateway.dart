import 'package:creddinv_task/features/checkout/data/payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';
import 'package:creddinv_task/features/checkout/data/payment_result.dart';

/// Cash on delivery. Same gateway contract, no charge is taken now.
class CodPaymentGateway implements PaymentGateway {
  const CodPaymentGateway({this.latency = const Duration(milliseconds: 650)});

  final Duration latency;

  @override
  PaymentMethod get method => PaymentMethod.cashOnDelivery;

  @override
  Future<PaymentResult> charge(PaymentRequest request) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    return PaymentResult(
      transactionId: 'cod-${request.orderId}',
      summary: 'Cash on delivery',
    );
  }
}
