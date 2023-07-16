import 'package:totick/app/entity/work_entity.dart';

import '../../../data/repositories/work_repository.dart';

class CreateOrReplaceWorkUseCase {
  final WorkRepository _workRepository;

  CreateOrReplaceWorkUseCase(this._workRepository);

  Future<int> execute(WorkEntity work) async {
    return await _workRepository.createOrReplace(work);
  }
}
