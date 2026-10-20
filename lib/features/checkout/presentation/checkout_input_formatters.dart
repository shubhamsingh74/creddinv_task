import 'package:flutter/services.dart';

/// Keeps checkout fields in the shape the validator expects while typing.
abstract final class CheckoutInputFormatters {
  static final List<TextInputFormatter> name = [_PersonNameFormatter()];
  static final List<TextInputFormatter> phone = [_DigitFormatter(10)];
  static final List<TextInputFormatter> cardNumber = [_CardNumberFormatter()];
  static final List<TextInputFormatter> expiry = [_ExpiryFormatter()];
  static final List<TextInputFormatter> cvv = [_DigitFormatter(4)];
  static final List<TextInputFormatter> upi = [_UpiFormatter()];
}

class _PersonNameFormatter extends TextInputFormatter {
  static final _drop = RegExp(r"[^A-Za-z .'\-]");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(_drop, '');
    if (text.length > 40) text = text.substring(0, 40);
    if (text == newValue.text) return newValue;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _DigitFormatter extends TextInputFormatter {
  _DigitFormatter(this.max);

  final int max;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > max) digits = digits.substring(0, max);
    if (digits == newValue.text) return newValue;
    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cursor = newValue.selection.end.clamp(0, newValue.text.length);
    var digitsBefore = newValue.text
        .substring(0, cursor)
        .replaceAll(RegExp(r'\D'), '')
        .length;
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 16) {
      digits = digits.substring(0, 16);
      if (digitsBefore > 16) digitsBefore = 16;
    }

    final buffer = StringBuffer();
    var caret = 0;
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
      if (i + 1 == digitsBefore) caret = buffer.length;
    }
    final text = buffer.toString();
    if (digitsBefore >= digits.length) caret = text.length;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: caret),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 4) digits = digits.substring(0, 4);
    final text = digits.length <= 2
        ? digits
        : '${digits.substring(0, 2)}/${digits.substring(2)}';
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _UpiFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'\s'), '').toLowerCase();
    if (text.length > 40) text = text.substring(0, 40);
    if (text == newValue.text) return newValue;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
