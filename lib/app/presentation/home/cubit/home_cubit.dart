import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/work/create_work_usecase.dart';
import '../../../domain/usecases/work/delete_work_usecase.dart';
import '../../../domain/usecases/work/get_works_usecase.dart';
import '../../../entity/work_entity.dart';
import '../section/work_create/home_work_create_state.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CreateWorkUseCase createWorkUseCase;
  final GetWorksUseCase getWorksUseCase;
  final DeleteWorkUseCase deleteWorkUseCase;

  HomeCubit({
    required this.createWorkUseCase,
    required this.getWorksUseCase,
    required this.deleteWorkUseCase,
  }) : super(const HomeState());

  Future<void> refresh() async {
    getWorks();
  }

  Future<void> createWork(String title, String description) async {
    try {
      await createWorkUseCase(
        WorkEntity(
          name: title,
          description: description,
          createdAt: DateTime.now(),
        ),
      );
      emit(state.copyWith(
        workCreateState: state.workCreateState.copyWith(
          phase: HomeWorkCreatePhase.success,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        workCreateState: state.workCreateState.copyWith(
          error: e.toString(),
          phase: HomeWorkCreatePhase.error,
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
