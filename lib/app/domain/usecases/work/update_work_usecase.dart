import '../../../data/repositories/work_repository.dart';
import '../../../entity/work_entity.dart';

class UpdateWorkUseCase {
  final WorkRepository _workRepository;

  UpdateWorkUseCase(this._workRepository);

  Future<int> call(WorkEntity work) async {
    return await _workRepository.update(work);
  }
}