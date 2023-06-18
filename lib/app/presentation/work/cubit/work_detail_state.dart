import 'package:equatable/equatable.dart';

import '../../../entity/work_entity.dart';

class WorkDetailState extends Equatable {
  final WorkEntity? work;
  final String? error;

  const WorkDetailState({this.work, this.error});

  @override
  List<Object?> get props => [work, error];

  WorkDetailState copyWith({
    WorkEntity? work,
    String? error,
  }) {
    return WorkDetailState(
      work: work ?? this.work,
      error: error ?? this.error,
    );
  }
}
