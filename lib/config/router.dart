import 'package:go_router/go_router.dart';
import 'package:totick/config/locator.dart';

import '../app/presentation/home/route/home_route.dart';

final router = GoRouter(
  initialLocation: HomeRoute.home,
  routes: [
    ...HomeRoute.builder(locator),
  ],
);
