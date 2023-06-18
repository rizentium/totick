import 'package:get_it/get_it.dart';

import 'usecases/work/create_work_usecase.dart';
import 'usecases/work/get_works_usecase.dart';

class DomainRegistrar {
  static Future<void> register(GetIt locator) async {
    // register use cases
    locator
      ..registerSingleton(CreateWorkUseCase(locator()))
      ..registerSingleton(GetWorksUseCase(locator()));
  }
}
