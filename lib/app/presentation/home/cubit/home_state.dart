import 'package:equatable/equatable.dart';

import '../section/work/home_work_state.dart';
import '../../work/section/work_form/work_form_state.dart';

class HomeState extends Equatable {
  final WorkFormState workFormState;
  final HomeWorkState workState;
  final String? error;

  const HomeState({
    this.workFormState = const WorkFormState(),
    this.workState = const HomeWorkState(),
    this.error,
  });

  @override
  List<Object?> get props => [workFormState, workState, error];

  HomeState copyWith({
    WorkFormState? workFormState,
    HomeWorkState? workState,
    String? error,
  }) {
    return HomeState(
      workFormState: workFormState ?? this.workFormState,
      workState: workState ?? this.workState,
      error: error ?? this.error,
    );
  }
}
