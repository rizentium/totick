import '../../../data/repositories/work_repository.dart';

class DeleteWorkUseCase {
  final WorkRepository _workRepository;

  DeleteWorkUseCase(this._workRepository);

  Future<bool> call(String workId) async {
    return await _workRepository.delete(workId);
  }
}
