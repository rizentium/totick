import '../../../data/repositories/work_repository.dart';
import '../../../entity/work_entity.dart';

class GetWorksUseCase {
  final WorkRepository _workRepository;

  GetWorksUseCase(this._workRepository);

  Future<List<WorkEntity>> call({int? id}) async {
    return await _workRepository.read(id: id);
  }
}
