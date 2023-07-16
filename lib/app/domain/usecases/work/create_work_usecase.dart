import '../../../data/repositories/work_repository.dart';
import '../../../entity/work_entity.dart';

@Deprecated('Use CreateOrUpdateWorkUseCase instead')
class CreateWorkUseCase {
  final WorkRepository _workRepository;

  CreateWorkUseCase(this._workRepository);

  Future<int> call(WorkEntity work) async {
    return await _workRepository.create(work);
  }
}
