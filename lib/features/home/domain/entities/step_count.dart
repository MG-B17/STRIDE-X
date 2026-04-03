class StepCountEntity {
  final int dailyStep;
  final int goalStep;
  final double reachedDayStep;
  final double calories;
  final double distance;
  final int activeTime;

  StepCountEntity({
    required this.dailyStep,
    required this.goalStep,
    required this.reachedDayStep,
    required this.calories,
    required this.distance,
    required this.activeTime,
  });
}
