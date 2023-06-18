import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screen/work_detail.dart';

class WorkRoute {
  static const String workDetail = '/work';

  static List<GoRoute> builder(GetIt locator) {
    return [
      GoRoute(
        path: workDetail,
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          return WorkDetailScreen.create(
            locator,
            workId: extra['workId'],
          );
        },
      ),
    ];
  }
}
