import 'package:equatable/equatable.dart';

class HomeWorkCreateState extends Equatable {
  final String? error;
  final HomeWorkCreatePhase phase;

  const HomeWorkCreateState({
    this.error,
    this.phase = HomeWorkCreatePhase.initial,
  });

  @override
  List<Object?> get props => [error, phase];

  HomeWorkCreateState copyWith({
    String? error,
    HomeWorkCreatePhase? phase,
  }) {
    return HomeWorkCreateState(
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
