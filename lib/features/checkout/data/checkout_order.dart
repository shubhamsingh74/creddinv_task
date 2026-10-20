import 'package:equatable/equatable.dart';

class CheckoutOrder extends Equatable {
  const CheckoutOrder({
    required this.id,
    required this.totalInCents,
    required this.itemCount,
    required this.paymentSummary,
    required this.recipientName,
  });

  final String id;
  final int totalInCents;
  final int itemCount;
  final String paymentSummary;
  final String recipientName;

  @override
  List<Object?> get props => [
    id,
    totalInCents,
    itemCount,
    paymentSummary,
    recipientName,
  ];
}
