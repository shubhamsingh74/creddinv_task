# Creddinv

Offline clothing shop. Sign in, browse a local catalog, and check out from the cart.

There is no backend, database, or Firebase. Products, photos, and the demo account live in the project. Payments are checked on the device and are not sent to a bank.

## Demo account

| Field | Value |
| --- | --- |
| Email | `demo@creddinv.com` |
| Password | `Demo@1234` |

Sign in stays disabled until the email is valid and the password has at least 8 characters with letters and numbers. The demo card on the login screen fills these fields. A wrong password shows `Invalid email or password.`

## Run

```bash
flutter pub get
flutter run
```

```bash
flutter test
flutter analyze
```

## Routes

Signed-out users stay on `/login`. A signed-in user is sent to `/products`. The cart and checkout are pushed, so back returns without dropping the cart.

1. **Login** (`/login`) — email, password with show/hide, and Sign in.
2. **Products** (`/products`) — 12 local pieces. Each card shows the photo, name, fabric, price, and Add to cart. Search, category filters, saved pieces, and sort (featured, price low to high, price high to low) narrow the list. Tap a card for the description, fabric, and fit. The bag icon opens the cart. Logout clears the cart, saved pieces, and the catalog filters.
3. **Cart** (`/cart`) — photo, name, price, quantity, remove, and the total. Quantity stays between 1 and 99. Remove deletes the line. An empty cart links back to the shop. Adding the same product again increases its quantity.
4. **Checkout** (`/checkout`) — delivery, then payment, then review. Place order clears the cart and shows the confirmation.

Checkout fields:

- Phone: 10 digits starting with 6, 7, 8, or 9. Example: `9876543210`.
- Address: street, city, and a 6-digit PIN. Example: `12 Market Street, Bengaluru 560001`.
- Card: `4242 4242 4242 4242`, expiry `12/30`, CVV `123`.
- UPI: an id like `name@bank`.
- Cash on delivery: no extra fields.

## Structure

```
lib/
  main.dart
  app.dart
  core/          theme, routes, validators, price format
  data/          models, local catalog, repositories
  features/
    auth/        LoginBloc for the form, AuthBloc for the session
    products/    ProductBloc, CatalogBloc, SavedBloc
    cart/        CartBloc
    checkout/    CheckoutBloc and the card, UPI, and cash gateways
  shared/widgets/
```

`CartBloc`, `CatalogBloc`, and `SavedBloc` sit above the router. `LoginBloc` and `CheckoutBloc` are created for their routes. Prices are integer cents. Login and checkout redact the password, card number, and CVV in `toString`.
