import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totick/app/domain/usecases/work/create_or_replace_work_usecase.dart';
import 'package:totick/app/domain/usecases/work/delete_work_usecase.dart';
import 'package:totick/app/entity/work_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/usecases/work/get_works_usecase.dart';
import '../../../entity/task_entity.dart';
import 'work_detail_state.dart';

class WorkDetailCubit extends Cubit<WorkDetailState> {
  final String? id;
  final GetWorksUseCase _getWorksUseCase;
  final CreateOrReplaceWorkUseCase _createOrReplaceWorkUseCase;
  final DeleteWorkUseCase _deleteWorkUseCase;

  WorkDetailCubit({
    this.id,
    required GetWorksUseCase getWorksUseCase,
    required CreateOrReplaceWorkUseCase createOrReplaceWorkUseCase,
    required DeleteWorkUseCase deleteWorkUseCase,
  })  : _getWorksUseCase = getWorksUseCase,
        _createOrReplaceWorkUseCase = createOrReplaceWorkUseCase,
        _deleteWorkUseCase = deleteWorkUseCase,
        super(const WorkDetailState());

  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true));

    // [works] is the collection of [WorkEntity] with length 1
    // because we use [GetWorksUseCase] to get the work by id
    final works = await _getWorksUseCase(id: id);

    emit(state.copyWith(work: works.first, isLoading: false));
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));
    final works = await _getWorksUseCase(id: id);
    emit(state.copyWith(work: works.first, isLoading: false));
  }

  Future<void> createTask(String name) async {
    final task = TaskEntity(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
    );

    final work = state.work?.copyWith(tasks: [...?state.work?.tasks, task]);

    try {
      if (work != null) {
        await _createOrReplaceWorkUseCase.execute(work);
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
        // Comparing e.id and e.createdAt to make sure that we are updating
        // the right task because Isar does'nt support updating by id for
        // embedded object
        if (e.id == task.id && e.createdAt == task.createdAt) return updated;
        return e;
      }).toList(),
    );

    try {
      if (work != null) {
        _createOrReplaceWorkUseCase.execute(work);
      }
      emit(state.copyWith(work: work));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void resetError() {
    emit(state.copyWith(error: null));
  }

  Future<void> deleteWork() async {
    final workId = state.work?.id;
    if (workId == null) return;
    try {
      await _deleteWorkUseCase(workId);
      emit(state.copyWith(error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> updateWork(WorkEntity? work) async {
    try {
      if (work == null) throw ErrorDescription('Work Entity is empty');
      await _createOrReplaceWorkUseCase.execute(work);
      emit(state.copyWith(work: work));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
