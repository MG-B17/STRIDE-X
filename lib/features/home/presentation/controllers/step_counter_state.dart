abstract class StepCounterState {} 

class Initial extends StepCounterState {} 

class Loading extends StepCounterState {}

class Loaded extends StepCounterState {
  final int dailyStep;
  final int goalStep;
  final double progressStep;

  Loaded({
    required this.dailyStep,
    required this.goalStep,
    required this.progressStep,
  });
}


class Error extends StepCounterState {
  final String message;

  Error({required this.message});
}