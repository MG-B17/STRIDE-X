import 'package:equatable/equatable.dart';

abstract class StepCounterState extends Equatable {
  const StepCounterState();

  @override
  List<Object?> get props => [];
}

class Initial extends StepCounterState {
  const Initial();
}

class Loading extends StepCounterState {
  const Loading();
}

class Loaded extends StepCounterState {
  final int dailyStep;
  final int goalStep;
  final double progressStep;
  final double calories;
  final double distance;
  final int activeTime;
  final List<double> weeklyValues;
  final int activeIndex;

  const Loaded({
    required this.dailyStep,
    required this.goalStep,
    required this.progressStep,
    required this.calories,
    required this.distance,
    required this.activeTime,
    required this.weeklyValues,
    required this.activeIndex,
  });

  @override
  List<Object?> get props => [
        dailyStep,
        goalStep,
        progressStep,
        calories,
        distance,
        activeTime,
        weeklyValues,
        activeIndex,
      ];
}

class Error extends StepCounterState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}



