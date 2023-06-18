import 'package:equatable/equatable.dart';

import '../../../entity/work_entity.dart';

class WorkDetailState extends Equatable {
  final WorkEntity? work;

  const WorkDetailState({this.work});

  @override
  List<Object?> get props => [work];

  WorkDetailState copyWith({
    WorkEntity? work,
  }) {
    return WorkDetailState(
      work: work ?? this.work,
    );
  }
}
