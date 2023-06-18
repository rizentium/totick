import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totick/app/domain/usecases/work/update_work_usecase.dart';

import '../../../domain/usecases/work/get_works_usecase.dart';
import '../../../entity/task_entity.dart';
import 'work_detail_state.dart';

class WorkDetailCubit extends Cubit<WorkDetailState> {
  final int? id;
  final GetWorksUseCase _getWorksUseCase;
  final UpdateWorkUseCase _updateWorkUseCase;

  WorkDetailCubit({
    this.id,
    required GetWorksUseCase getWorksUseCase,
    required UpdateWorkUseCase updateWorkUseCase,
  })  : _getWorksUseCase = getWorksUseCase,
        _updateWorkUseCase = updateWorkUseCase,
        super(const WorkDetailState());

  Future<void> initialize() async {
    final works = await _getWorksUseCase(id: id);
    emit(state.copyWith(work: works.first));
  }

  Future<void> refresh() async {
    final works = await _getWorksUseCase(id: id);
    emit(state.copyWith(work: works.first));
  }

  Future<void> createTask(String name) async {
    final task = TaskEntity(
      id: state.work?.tasks?.length ?? 0 + 1,
      name: name,
      createdAt: DateTime.now(),
    );

    final work = state.work?.copyWith(tasks: [...?state.work?.tasks, task]);

    try {
      if (work != null) {
        await _updateWorkUseCase(work);
      }

      emit(state.copyWith(work: work));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void updateTask(TaskEntity task) {
    final progress = task.progress ?? 0;
    final updated = task.copyWith(progress: progress == 0 ? 100 : 0);

    final work = state.work?.copyWith(
      tasks: state.work?.tasks?.map((e) {
        if (e.id == task.id) return updated;
        return e;
      }).toList(),
    );

    try {
      if (work != null) {
        _updateWorkUseCase(work);
      }
      emit(state.copyWith(work: work));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
