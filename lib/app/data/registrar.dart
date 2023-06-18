import 'package:get_it/get_it.dart';

import 'repositories/work_repository.dart';
import 'services/work_service.dart';

class DataRegistrar {
  static Future<void> register(GetIt locator) async {
    // register services
    locator.registerSingleton(WorkService(locator()));
    // register repositories
    locator.registerSingleton(WorkRepository(locator()));
  }
}
