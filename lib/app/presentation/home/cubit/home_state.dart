import 'package:equatable/equatable.dart';

import '../section/work/home_work_state.dart';
import '../section/work_form/home_work_form_state.dart';

class HomeState extends Equatable {
  final HomeWorkFormState workFormState;
  final HomeWorkState workState;
  final String? error;

  const HomeState({
    this.workFormState = const HomeWorkFormState(),
    this.workState = const HomeWorkState(),
    this.error,
  });

  @override
  List<Object?> get props => [workFormState, workState, error];

  HomeState copyWith({
    HomeWorkFormState? workFormState,
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
