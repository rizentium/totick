import 'package:totick/app/data/services/work_service.dart';

import '../../entity/work_entity.dart';

class WorkRepository {
  final WorkService _workService;

  WorkRepository(this._workService);

  Future<int> create(WorkEntity entity) async {
    return await _workService.createOrReplace(entity);
  }

  Future<int> update(WorkEntity entity) async {
    return await _workService.createOrReplace(entity);
  }

  Future<List<WorkEntity>> read({int? id}) async {
    return await _workService.read(id: id);
  }

  Future<bool> delete(int id) async {
    return await _workService.delete(id);
  }
}
