import 'package:equatable/equatable.dart';

import '../../../../entity/work_entity.dart';

class WorkFormState extends Equatable {
  final WorkEntity? work;
  final String? error;
  final WorkStatePhase phase;

  const WorkFormState({
    this.work,
    this.error,
    this.phase = WorkStatePhase.initial,
  });

  @override
  List<Object?> get props => [work, error, phase];

  WorkFormState copyWith({
    WorkEntity? work,
    String? error,
    WorkStatePhase? phase,
  }) {
    return WorkFormState(
      work: work ?? this.work,
      error: error ?? this.error,
      phase: phase ?? this.phase,
    );
  }
}

enum WorkStatePhase {
  initial,
  loading,
  loaded,
  error,
  success,
}
