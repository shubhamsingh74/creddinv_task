part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

final class CheckoutDraftChanged extends CheckoutEvent {
  const CheckoutDraftChanged(this.draft);

  final CheckoutDraft draft;

  @override
  List<Object?> get props => [draft];

  @override
  String toString() => 'CheckoutDraftChanged([redacted])';
}

final class CheckoutStepAdvanced extends CheckoutEvent {
  const CheckoutStepAdvanced();
}

final class CheckoutStepReverted extends CheckoutEvent {
  const CheckoutStepReverted();
}

final class CheckoutSubmitted extends CheckoutEvent {
  const CheckoutSubmitted(this.items);

  final List<CartItem> items;

  @override
  List<Object?> get props => [items];
}
