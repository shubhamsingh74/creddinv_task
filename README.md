# Creddinv

A small clothing shop: sign in, browse a local catalog, and manage a cart.

The app is offline. Products, photos, and the demo account all live in the project. There is no backend, database, or Firebase.

## Demo account

| Field | Value |
| --- | --- |
| Email | `demo@creddinv.com` |
| Password | `Demo@1234` |

The login button stays disabled until the email is valid and the password has at least 8 characters, including letters and numbers. The demo card on the login screen can fill these fields.

A valid form with the wrong password shows `Invalid email or password.`

## Run

```bash
flutter pub get
flutter run
```

```bash
flutter test
flutter analyze
```

## What the three screens do

1. **Login** (`/login`) — required email and password, show/hide password, and a button that enables only for valid input.
2. **Products** (`/products`) — six clothing items in reusable cards (photo, name, short description, price, Add to cart). The bag icon opens the cart. Logging out clears the cart and returns to login.
3. **Cart** (`/cart`) — photo, name, price, quantity, remove, and the total. Quantity cannot go below 1; remove deletes the line. An empty cart explains itself and links back to the shop.

Adding the same product again increases its quantity. Cart contents stay put while moving between the shop and the cart, because `CartBloc` sits above the router.

## How it is put together

```
lib/
  main.dart                 # debug BlocObserver, then CreddinvApp
  app.dart                  # blocs, ScreenUtil, MaterialApp.router
  core/                     # theme, routes, validators, price format
  data/                     # models, local catalog, auth repository
  features/
    auth/                   # LoginBloc (form) and AuthBloc (session)
    products/               # ProductBloc
    cart/                   # CartBloc
  shared/widgets/           # buttons, fields, product image, cart badge
```

- **BLoC** owns state. `LoginBloc` decides when the form can submit. `AuthBloc` checks the local account. `ProductBloc` loads the catalog. `CartBloc` is the only place that changes quantities and the total.
- **go_router** maps `/login`, `/products`, and `/cart`. A redirect keeps signed-out users on login and sends a signed-in user from login to the catalog. The cart is pushed, so the back button returns to the shop without dropping cart state.
- **flutter_screenutil** scales spacing, type, and radii from a 390×844 design (iPhone 14 points).
- **Repositories** hide the dummy account and the static list. Screens never read those sources directly, so a later API would replace the repository, not the widgets.
- **Sealed states** make the loading, ready, and failure branches explicit in the UI.

## Production rules this code follows

- **Money is integer cents.** Prices never use `double`, and formatting builds the dollar string from whole cents so `$1.99` cannot become `$1.98`.
- **Secrets stay out of logs.** Login state and the login event redact the password in `toString`. The bloc observer only runs in debug.
- **Logout owns its side effects.** Ending the session clears the cart from one listener on `AuthBloc`. The logout button does not have to remember that.
- **Cart quantity is bounded** from 1 to 99 in `CartBloc`, and the product card explains the cap instead of pretending the extra tap was added.
- **Futures are not dropped.** Bloc `close()` calls in `dispose` are wrapped with `unawaited`.
- **Release failures stay contained.** Uncaught errors are logged. In release, a broken widget shows a short message instead of the red error screen. Unknown routes have their own page.
- **Analyzer is strict:** `strict-casts`, `strict-inference`, `strict-raw-types`, and the extra lint set in `analysis_options.yaml`. `flutter analyze` is expected to be clean before a pull request.

## Submission video

Record a short pass that shows:

1. Login button disabled, then enabled, then a successful sign-in.
2. The product list.
3. Add to cart, open the cart, increase quantity, and check the total.
4. Remove the item and show the empty-cart message.
5. Return to the shop and confirm the cart is still there if you add something, leave, and come back.
