import 'package:equatable/equatable.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';

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
  final UserPhysicalData? userPhysicalData;

  const Loaded({
    required this.dailyStep,
    required this.goalStep,
    required this.progressStep,
    required this.calories,
    required this.distance,
    required this.activeTime,
    this.userPhysicalData,
  });

  @override
  List<Object?> get props => [
        dailyStep,
        goalStep,
        progressStep,
        calories,
        distance,
        activeTime,
        userPhysicalData,
      ];
}

class Error extends StepCounterState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}