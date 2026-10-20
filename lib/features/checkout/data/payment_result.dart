import 'package:equatable/equatable.dart';

class PaymentResult extends Equatable {
  const PaymentResult({required this.transactionId, required this.summary});

  final String transactionId;
  final String summary;

  @override
  List<Object?> get props => [transactionId, summary];
}
