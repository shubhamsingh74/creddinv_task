import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_draft.dart';
import 'package:creddinv_task/features/checkout/data/checkout_order.dart';
import 'package:creddinv_task/features/checkout/data/payment_exception.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway_registry.dart';
import 'package:creddinv_task/features/checkout/data/payment_request.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required PaymentGatewayRegistry gateways,
    String Function()? orderId,
  }) : _gateways = gateways,
       _orderId = orderId ?? _defaultOrderId,
       super(const CheckoutState()) {
    on<CheckoutDraftChanged>(_onDraft);
    on<CheckoutStepAdvanced>(_onAdvanced);
    on<CheckoutStepReverted>(_onReverted);
    on<CheckoutSubmitted>(_onSubmitted);
  }

  final PaymentGatewayRegistry _gateways;
  final String Function() _orderId;

  void _onDraft(CheckoutDraftChanged event, Emitter<CheckoutState> emit) {
    if (state.order != null || state.submitting) return;
    emit(state.copyWith(draft: event.draft, clearError: true));
  }

  void _onAdvanced(CheckoutStepAdvanced event, Emitter<CheckoutState> emit) {
    if (!state.canContinue || state.submitting) return;
    final next = switch (state.step) {
      CheckoutStep.details => CheckoutStep.payment,
      CheckoutStep.payment => CheckoutStep.review,
      CheckoutStep.review || CheckoutStep.complete => state.step,
    };
    emit(state.copyWith(step: next, clearError: true));
  }

  void _onReverted(CheckoutStepReverted event, Emitter<CheckoutState> emit) {
    final previous = switch (state.step) {
      CheckoutStep.payment => CheckoutStep.details,
      CheckoutStep.review => CheckoutStep.payment,
      CheckoutStep.details || CheckoutStep.complete => state.step,
    };
    emit(state.copyWith(step: previous, clearError: true));
  }

  Future<void> _onSubmitted(
    CheckoutSubmitted event,
    Emitter<CheckoutState> emit,
  ) async {
    if (state.submitting || state.order != null) return;
    if (event.items.isEmpty || !state.draft.detailsValid) {
      emit(state.copyWith(error: 'Your bag is empty.'));
      return;
    }
    if (!state.draft.paymentValid) {
      emit(state.copyWith(error: 'Check the payment details.'));
      return;
    }

    final draft = state.draft;
    final orderId = _orderId();
    final total = event.items.fold<int>(
      0,
      (sum, item) => sum + item.lineTotalInCents,
    );
    emit(state.copyWith(submitting: true, clearError: true));

    try {
      final result = await _gateways
          .gatewayFor(draft.method)
          .charge(
            PaymentRequest(
              amountInCents: total,
              orderId: orderId,
              cardNumber: draft.cardNumber,
              expiry: draft.expiry,
              cvv: draft.cvv,
              upiId: draft.upiId,
            ),
          );
      emit(
        state.copyWith(
          submitting: false,
          step: CheckoutStep.complete,
          order: CheckoutOrder(
            id: orderId,
            totalInCents: total,
            itemCount: event.items.fold<int>(
              0,
              (sum, item) => sum + item.quantity,
            ),
            paymentSummary: result.summary,
            recipientName: draft.name.trim(),
          ),
        ),
      );
    } on PaymentException catch (error) {
      emit(state.copyWith(submitting: false, error: error.message));
    } on Object {
      emit(
        state.copyWith(submitting: false, error: AppStrings.unexpectedError),
      );
    }
  }

  static String _defaultOrderId() {
    final stamp = DateTime.now().millisecondsSinceEpoch
        .toRadixString(16)
        .toUpperCase();
    return 'CRD-$stamp';
  }
}
