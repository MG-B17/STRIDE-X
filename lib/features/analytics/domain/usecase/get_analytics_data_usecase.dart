import 'dart:math';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/features/analytics/domain/entity/analytics_data_entity.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class GetAnalyticsDataUsecase {
  final StepRepositories stepRepositories;

  GetAnalyticsDataUsecase({required this.stepRepositories});

  Future<AnalyticsDataEntity> call(int daysToAnalyze) async {
    final List<TodayDataEntity> historicalData =
        await stepRepositories.getLastNDaysData(daysToAnalyze);

    final int stepGoal = CachedData.userPhysicalData.stepGoal;

    int totalSteps = 0;
    double totalCalories = 0.0;
    int goalReached = 0;
    int nearGoal = 0;
    int belowGoal = 0;
    
    
    List<int> dailyStepsArr = List.filled(daysToAnalyze, 0);
    final today = DateTime.now();
    for (var entity in historicalData) {
      final daysAgo = today.difference(entity.date).inDays;
      if (daysAgo >= 0 && daysAgo < daysToAnalyze) {
        dailyStepsArr[daysToAnalyze - 1 - daysAgo] = entity.stepsCount;
        
        totalSteps += entity.stepsCount;
        totalCalories += entity.calories;

        double progress = entity.stepsCount / stepGoal;
        if (progress >= 1.0) {
          goalReached++;
        } else if (progress >= 0.8) {
          nearGoal++;
        } else {
          belowGoal++;
        }
      }
    }

    final maxSteps = dailyStepsArr.reduce(max);
    List<double> performanceRatios = dailyStepsArr.map((steps) {
      if (maxSteps == 0) return 0.0;
      return (steps / maxSteps).clamp(0.0, 1.0);
    }).toList();


    belowGoal += (daysToAnalyze - historicalData.length);

    int averageSteps = totalSteps ~/ daysToAnalyze;
    double averageActiveBurn = totalCalories / daysToAnalyze;

    return AnalyticsDataEntity(
      averageSteps: averageSteps,
      performanceRatios: performanceRatios,
      totalWeeklySteps: totalSteps,
      goalReachedDays: goalReached,
      nearGoalDays: nearGoal,
      belowGoalDays: belowGoal,
      averageActiveBurn: averageActiveBurn,
    );
  }
}
