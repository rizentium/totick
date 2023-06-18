import 'package:equatable/equatable.dart';

import '../section/work/home_work_state.dart';
import '../section/work_create/home_work_create_state.dart';

class HomeState extends Equatable {
  final HomeWorkCreateState workCreateState;
  final HomeWorkState workState;

  const HomeState({
    this.workCreateState = const HomeWorkCreateState(),
    this.workState = const HomeWorkState(),
  });

  @override
  List<Object?> get props => [workCreateState, workState];

  HomeState copyWith({
    HomeWorkCreateState? workCreateState,
    HomeWorkState? workState,
  }) {
    return HomeState(
      workCreateState: workCreateState ?? this.workCreateState,
      workState: workState ?? this.workState,
    );
  }
}
