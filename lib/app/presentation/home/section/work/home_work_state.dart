import 'package:equatable/equatable.dart';

import '../../../../entity/work_entity.dart';

class HomeWorkState extends Equatable {
  final List<WorkEntity> works;

  const HomeWorkState({
    this.works = const [],
  });

  @override
  List<Object?> get props => [works];

  HomeWorkState copyWith({
    List<WorkEntity>? works,
  }) {
    return HomeWorkState(
      works: works ?? this.works,
    );
  }
}
