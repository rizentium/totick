import 'package:isar/isar.dart';
import 'package:totick/core/extensions/data_types.dart';

import '../../entity/work_entity.dart';

class WorkService {
  final Isar _isar;

  WorkService(this._isar);

  Future<int> createOrReplace(WorkEntity entity) async {
    return await _isar.writeTxn(
      () async => await _isar.workEntitys.put(entity),
    );
  }

  Future<List<WorkEntity>> read({String? id}) async {
    if (id != null) {
      return _isar.workEntitys.filter().idEqualTo(id).findAll();
    }
    return await _isar.workEntitys.where().findAll();
  }

  Future<bool> delete(String id) async {
    return _isar.writeTxn(
      () async => await _isar.workEntitys.delete(id.fastHash),
    );
  }
}
