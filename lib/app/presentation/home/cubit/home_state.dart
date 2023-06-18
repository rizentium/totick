import 'package:equatable/equatable.dart';

import '../section/work/home_work_state.dart';
import '../section/work_create/home_work_create_state.dart';

class HomeState extends Equatable {
  final HomeWorkCreateState workCreateState;
  final HomeWorkState workState;
  final String? error;

  const HomeState({
    this.workCreateState = const HomeWorkCreateState(),
    this.workState = const HomeWorkState(),
    this.error,
  });

  @override
  List<Object?> get props => [workCreateState, workState, error];

  HomeState copyWith({
    HomeWorkCreateState? workCreateState,
    HomeWorkState? workState,
    String? error,
  }) {
    return HomeState(
      workCreateState: workCreateState ?? this.workCreateState,
      workState: workState ?? this.workState,
      error: error ?? this.error,
    );
  }
}
