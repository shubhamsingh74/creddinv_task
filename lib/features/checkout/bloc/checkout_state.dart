part of 'checkout_bloc.dart';

enum CheckoutStep { details, payment, review, complete }

final class CheckoutState extends Equatable {
  const CheckoutState({
    this.step = CheckoutStep.details,
    this.draft = const CheckoutDraft(),
    this.submitting = false,
    this.error,
    this.order,
  });

  final CheckoutStep step;
  final CheckoutDraft draft;
  final bool submitting;
  final String? error;
  final CheckoutOrder? order;

  bool get canContinue => switch (step) {
    CheckoutStep.details => draft.detailsValid,
    CheckoutStep.payment => draft.paymentValid,
    CheckoutStep.review =>
      draft.detailsValid && draft.paymentValid && !submitting,
    CheckoutStep.complete => false,
  };

  CheckoutState copyWith({
    CheckoutStep? step,
    CheckoutDraft? draft,
    bool? submitting,
    String? error,
    bool clearError = false,
    CheckoutOrder? order,
  }) {
    return CheckoutState(
      step: step ?? this.step,
      draft: draft ?? this.draft,
      submitting: submitting ?? this.submitting,
      error: clearError ? null : error ?? this.error,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [step, draft, submitting, error, order];

  @override
  String toString() {
    return 'CheckoutState(step: $step, method: ${draft.method}, '
        'card: [redacted], cvv: [redacted], submitting: $submitting, '
        'error: $error, order: ${order?.id})';
  }
}
