import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/data/sources/local_product_data.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_draft.dart';
import 'package:creddinv_task/features/checkout/data/card_payment_gateway.dart';
import 'package:creddinv_task/features/checkout/data/payment_exception.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway_registry.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';

void main() {
  const registry = PaymentGatewayRegistry(latency: Duration.zero);
  final item = CartItem(product: LocalProductData.products.first, quantity: 1);

  blocTest<CheckoutBloc, CheckoutState>(
    'places a cash order through the cash gateway',
    build: () => CheckoutBloc(gateways: registry, orderId: () => 'CRD-TEST'),
    seed: () => const CheckoutState(
      step: CheckoutStep.review,
      draft: CheckoutDraft(
        name: 'Demo Shopper',
        phone: '9876543210',
        address: '12 Market Street, 560001',
        method: PaymentMethod.cashOnDelivery,
      ),
    ),
    act: (bloc) => bloc.add(CheckoutSubmitted([item])),
    expect: () => [
      isA<CheckoutState>().having(
        (state) => state.submitting,
        'submitting',
        true,
      ),
      isA<CheckoutState>()
          .having((state) => state.order?.id, 'order id', 'CRD-TEST')
          .having(
            (state) => state.order?.paymentSummary,
            'summary',
            'Cash on delivery',
          )
          .having((state) => state.submitting, 'submitting', false),
    ],
  );

  test('card gateway accepts a valid demo card and hides the number', () async {
    const gateway = CardPaymentGateway(latency: Duration.zero);
    final result = await gateway.charge(
      const PaymentRequest(
        amountInCents: 5200,
        orderId: 'CRD-TEST',
        cardNumber: '4242 4242 4242 4242',
        expiry: '12/30',
        cvv: '123',
      ),
    );

    expect(result.summary, 'Card •••• 4242');
    expect(result.summary.contains('4242424242424242'), isFalse);
  });

  test('card gateway declines a bad number', () async {
    const gateway = CardPaymentGateway(latency: Duration.zero);
    expect(
      gateway.charge(
        const PaymentRequest(
          amountInCents: 5200,
          orderId: 'CRD-TEST',
          cardNumber: '1111 1111 1111 1111',
          expiry: '12/30',
          cvv: '123',
        ),
      ),
      throwsA(isA<PaymentException>()),
    );
  });

  test('checkout state does not print the card', () {
    const state = CheckoutState(
      draft: CheckoutDraft(cardNumber: '4242424242424242', cvv: '123'),
    );
    expect(state.toString().contains('4242424242424242'), isFalse);
    expect(state.toString().contains('123'), isFalse);
  });
}
