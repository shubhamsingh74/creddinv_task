abstract final class CheckoutValidator {
  static String? name(String value) {
    final trimmed = value.trim();
    if (trimmed.length < 2) return 'Enter the recipient name';
    if (trimmed.length > 40) return 'Use a shorter name';
    if (!RegExp(r"^[A-Za-z][A-Za-z .'\-]{1,}$").hasMatch(trimmed)) {
      return 'Use letters only';
    }
    return null;
  }

  static String? phone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return 'Enter a 10-digit mobile number';
    if (!RegExp(r'^[6-9]').hasMatch(digits)) {
      return 'Mobile numbers start with 6, 7, 8, or 9';
    }
    return null;
  }

  static String? address(String value) {
    final trimmed = value.trim();
    if (trimmed.length < 8) return 'Enter the street and city';
    if (trimmed.length > 120) return 'Keep the address shorter';
    if (!RegExp(r'[A-Za-z]').hasMatch(trimmed)) {
      return 'Include the street and city';
    }
    if (!RegExp(r'(^|\D)\d{6}(\D|$)').hasMatch(trimmed)) {
      return 'Include a 6-digit PIN code';
    }
    return null;
  }

  static String? cardNumber(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return 'Enter the card number';
    if (digits.length != 16) return 'Enter all 16 digits';
    if (!_luhn(digits)) return 'That card number is not valid';
    return null;
  }

  static String? expiry(String value) {
    final match = RegExp(
      r'^(0[1-9]|1[0-2])\/(\d{2})$',
    ).firstMatch(value.trim());
    if (match == null) return 'Use MM/YY, like 12/30';
    final month = int.parse(match.group(1)!);
    final year = 2000 + int.parse(match.group(2)!);
    final now = DateTime.now();
    final expired = year < now.year || (year == now.year && month < now.month);
    if (expired) return 'This card has expired';
    return null;
  }

  static String? cvv(String value) {
    final code = value.trim();
    if (code.isEmpty) return 'Enter the security code';
    if (!RegExp(r'^\d{3,4}$').hasMatch(code)) return 'Use 3 or 4 digits';
    return null;
  }

  static String? upi(String value) {
    final id = value.trim();
    if (id.length < 5 || id.length > 40) {
      return 'Enter a UPI id like name@bank';
    }
    if (!RegExp(r'^[\w.\-]{2,}@[A-Za-z][\w.\-]{1,}$').hasMatch(id)) {
      return 'Enter a UPI id like name@bank';
    }
    return null;
  }

  static bool _luhn(String digits) {
    var sum = 0;
    var alternate = false;
    for (var i = digits.length - 1; i >= 0; i--) {
      var n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }
}
