import 'package:equatable/equatable.dart';

class AnalyticsDataEntity extends Equatable {
  final int averageSteps;
  final List<double> performanceRatios;
  final int totalWeeklySteps;
  final int goalReachedDays;
  final int nearGoalDays;
  final int belowGoalDays;
  final double averageActiveBurn;

  const AnalyticsDataEntity({
    required this.averageSteps,
    required this.performanceRatios,
    required this.totalWeeklySteps,
    required this.goalReachedDays,
    required this.nearGoalDays,
    required this.belowGoalDays,
    required this.averageActiveBurn,
  });

  @override
  List<Object?> get props => [
        averageSteps,
        performanceRatios,
        totalWeeklySteps,
        goalReachedDays,
        nearGoalDays,
        belowGoalDays,
        averageActiveBurn,
      ];
}



