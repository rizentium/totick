import 'package:flutter/material.dart';

import '../config/environment.dart';
import '../config/router.dart';
import '../core/design/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Environment.name,
      theme: ToTickTheme.primary,
      routerConfig: router,
    );
  }
}
