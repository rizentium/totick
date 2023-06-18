import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/work/get_works_usecase.dart';
import 'work_detail_state.dart';

class WorkDetailCubit extends Cubit<WorkDetailState> {
  final int? id;
  final GetWorksUseCase _getWorksUseCase;

  WorkDetailCubit({
    this.id,
    required GetWorksUseCase getWorksUseCase,
  })  : _getWorksUseCase = getWorksUseCase,
        super(const WorkDetailState());

  Future<void> initialize() async {
    final works = await _getWorksUseCase(id: id);
    emit(state.copyWith(work: works.first));
  }
}
