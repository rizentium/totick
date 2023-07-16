import 'package:equatable/equatable.dart';

import '../../../../entity/work_entity.dart';

class HomeWorkFormState extends Equatable {
  final WorkEntity? work;
  final String? error;
  final HomeWorkCreatePhase phase;

  const HomeWorkFormState({
    this.work,
    this.error,
    this.phase = HomeWorkCreatePhase.initial,
  });

  @override
  List<Object?> get props => [work, error, phase];

  HomeWorkFormState copyWith({
    WorkEntity? work,
    String? error,
    HomeWorkCreatePhase? phase,
  }) {
    return HomeWorkFormState(
      work: work ?? this.work,
      error: error ?? this.error,
      phase: phase ?? this.phase,
    );
  }
}

enum HomeWorkCreatePhase {
  initial,
  loading,
  loaded,
  error,
  success,
}
