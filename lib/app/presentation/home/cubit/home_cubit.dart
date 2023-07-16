import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/work/create_or_replace_work_usecase.dart';
import '../../../domain/usecases/work/delete_work_usecase.dart';
import '../../../domain/usecases/work/get_works_usecase.dart';
import '../../../entity/work_entity.dart';
import '../../work/section/work_form/work_form_state.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreateOrReplaceWorkUseCase createOrReplaceWorkUseCase;
  final GetWorksUseCase getWorksUseCase;
  final DeleteWorkUseCase deleteWorkUseCase;

  HomeCubit({
    required this.createOrReplaceWorkUseCase,
    required this.getWorksUseCase,
    required this.deleteWorkUseCase,
  }) : super(const HomeState());

  Future<void> refresh() async {
    getWorks();
  }

  Future<void> createOrUpdateWork(WorkEntity? work) async {
    try {
      if (work == null) throw ErrorDescription('Work Entity is empty');
      await createOrReplaceWorkUseCase.execute(work);
      emit(state.copyWith(
        workFormState: state.workFormState.copyWith(
          phase: WorkStatePhase.success,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        workFormState: state.workFormState.copyWith(
          error: e.toString(),
          phase: WorkStatePhase.error,
        ),
      ));
    }
    refresh();
  }

  Future<void> getWorks() async {
    final works = await getWorksUseCase();
    emit(state.copyWith(workState: state.workState.copyWith(works: works)));
  }

  Future<void> deleteWork(int id) async {
    try {
      await deleteWorkUseCase(id);
      refresh();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
