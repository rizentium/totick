import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  runApp(const App());
}
