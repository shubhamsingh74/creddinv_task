import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/utils/price_formatter.dart';

void main() {
  test('formats cents without binary rounding', () {
    expect(PriceFormatter.formatCents(5200), '\$52.00');
    expect(PriceFormatter.formatCents(120000), '\$1,200.00');
    expect(PriceFormatter.formatCents(199), '\$1.99');
  });
}
