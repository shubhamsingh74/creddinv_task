import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:creddinv_task/core/error/release_error_fallback.dart';

/// Installs handlers that keep a release build from dying on one bad frame.
void installErrorHandlers() {
  FlutterError.onError = FlutterError.presentError;

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('Uncaught error: $error');
    debugPrint('$stack');
    return kReleaseMode;
  };

  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return const ReleaseErrorFallback();
    };
  }
}
