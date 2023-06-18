import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screen/home_screen.dart';

class HomeRoute {
  static const String home = '/home';

  static List<GoRoute> builder(GetIt locator) {
    return [
      GoRoute(
        path: home,
        builder: (context, state) => HomeScreen.create(locator),
      ),
    ];
  }
}
