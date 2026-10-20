import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/app.dart';
import 'package:creddinv_task/core/error/app_error_handlers.dart';
import 'package:creddinv_task/core/observer/app_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  installErrorHandlers();
  if (kDebugMode) {
    Bloc.observer = const AppBlocObserver();
  }
  runApp(const CreddinvApp());
}
