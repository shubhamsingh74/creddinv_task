import 'package:intl/intl.dart';

/// Formats USD from integer cents so totals never depend on binary floats.
abstract final class PriceFormatter {
  static final NumberFormat _dollars = NumberFormat.decimalPattern('en_US');

  static String formatCents(int cents) {
    final negative = cents < 0;
    final absolute = cents.abs();
    final whole = absolute ~/ 100;
    final fraction = (absolute % 100).toString().padLeft(2, '0');
    final sign = negative ? '-' : '';
    return '$sign\$${_dollars.format(whole)}.$fraction';
  }
}
