import 'package:get_it/get_it.dart';

import 'usecases/work/create_or_replace_work_usecase.dart';
import 'usecases/work/create_work_usecase.dart';
import 'usecases/work/delete_work_usecase.dart';
import 'usecases/work/get_works_usecase.dart';
import 'usecases/work/update_work_usecase.dart';

class DomainRegistrar {
  static Future<void> register(GetIt locator) async {
    // register use cases
    locator
      ..registerSingleton(CreateOrReplaceWorkUseCase(locator()))
      ..registerSingleton(CreateWorkUseCase(locator()))
      ..registerSingleton(GetWorksUseCase(locator()))
      ..registerSingleton(UpdateWorkUseCase(locator()))
      ..registerSingleton(DeleteWorkUseCase(locator()));
  }
}
