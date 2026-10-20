import 'package:creddinv_task/features/checkout/data/card_payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/cod_payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/upi_payment_gateway.dart';

/// Picks the integration for the method the shopper chose.
class PaymentGatewayRegistry {
  const PaymentGatewayRegistry({
    this.latency = const Duration(milliseconds: 650),
  });

  final Duration latency;

  PaymentGateway gatewayFor(PaymentMethod method) {
    return switch (method) {
      PaymentMethod.card => CardPaymentGateway(latency: latency),
      PaymentMethod.upi => UpiPaymentGateway(latency: latency),
      PaymentMethod.cashOnDelivery => CodPaymentGateway(latency: latency),
    };
  }
}
