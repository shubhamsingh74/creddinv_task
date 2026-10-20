import 'package:flutter/material.dart';

import 'package:creddinv_task/core/theme/app_gradients.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.body, this.appBar, super.key});

  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.canvas),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
      ),
    );
  }
}
