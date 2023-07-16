import 'package:equatable/equatable.dart';

import '../../../entity/work_entity.dart';

class WorkDetailState extends Equatable {
  final bool isLoading;
  final WorkEntity? work;
  final String? error;

  const WorkDetailState({this.isLoading = false, this.work, this.error});

  @override
  List<Object?> get props => [isLoading, work, error];

  WorkDetailState copyWith({
    bool? isLoading,
    WorkEntity? work,
    String? error,
  }) {
    return WorkDetailState(
      isLoading: isLoading ?? this.isLoading,
      work: work ?? this.work,
      error: error ?? this.error,
    );
  }
}
