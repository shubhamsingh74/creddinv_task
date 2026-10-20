import 'dart:async';

import 'package:flutter/foundation.dart';

/// Notifies the router whenever the provided stream emits so redirect can re-run.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      if (!_isDisposed) notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;
  var _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
