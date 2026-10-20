import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/app.dart';
import 'package:creddinv_task/core/constants/app_layout.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/data/sources/local_product_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login, cart updates, and logout', (tester) async {
    tester.view.physicalSize = AppLayout.designSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CreddinvApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);

    await tester.ensureVisible(find.text('Use demo account'));
    await tester.tap(find.text('Use demo account'));
    await tester.pump();

    await tester.ensureVisible(find.text('Sign in'));
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    final product = LocalProductData.products.first;
    expect(find.text(product.name), findsOneWidget);
    expect(find.text('New arrivals'), findsOneWidget);

    await tester.ensureVisible(find.text('Add to cart').first);
    await tester.pump();
    await tester.tap(find.text('Add to cart').first);
    await tester.pump();
    expect(find.text('Added to cart'), findsOneWidget);
    expect(find.text('1 in cart'), findsOneWidget);

    await tester.tap(find.byTooltip('Open cart'));
    await tester.pumpAndSettle();

    expect(find.text('Your cart is empty'), findsNothing);
    expect(
      find.text(PriceFormatter.formatCents(product.priceInCents)),
      findsWidgets,
    );
    expect(find.text('1 item'), findsOneWidget);

    await tester.tap(find.byTooltip('Increase quantity'));
    await tester.pump();
    expect(find.text('2 items'), findsOneWidget);
    expect(
      find.text(PriceFormatter.formatCents(product.priceInCents * 2)),
      findsWidgets,
    );

    await tester.tap(find.byTooltip('Remove item'));
    await tester.pumpAndSettle();
    expect(find.text('Your cart is empty'), findsOneWidget);

    await tester.ensureVisible(find.text('Browse products'));
    await tester.tap(find.text('Browse products'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Log out'), findsOneWidget);

    await tester.ensureVisible(find.text('Add to cart').first);
    await tester.pump();
    await tester.tap(find.text('Add to cart').first);
    await tester.pump();
    expect(find.text('1 in cart'), findsOneWidget);

    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.ensureVisible(find.text('Use demo account'));
    await tester.tap(find.text('Use demo account'));
    await tester.pump();
    await tester.ensureVisible(find.text('Sign in'));
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('1 in cart'), findsNothing);
    expect(find.text('New arrivals'), findsOneWidget);
  });
}
