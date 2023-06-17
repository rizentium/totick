import 'package:go_router/go_router.dart';

import '../screen/home_screen.dart';

class HomeRoute {
  static const String home = '/home';

  static List<GoRoute> builder() {
    return [
      GoRoute(
        path: home,
        builder: (context, state) => const MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    ];
  }
}
