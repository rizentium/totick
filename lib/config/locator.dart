import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../app/data/registrar.dart';
import '../app/domain/registrar.dart';
import '../app/entity/work_entity.dart';

final locator = GetIt.instance;

Future<void> setupGetIt() async {
  locator.registerSingleton<Isar>(
    await Isar.open(
      [WorkEntitySchema],
      directory: (await getApplicationDocumentsDirectory()).path,
    ),
  );

  await DataRegistrar.register(locator);
  await DomainRegistrar.register(locator);

  // register use cases
  // register cubits
  // register pages
  // register widgets
}
