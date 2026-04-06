import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class WeeklyProgressUsecase {
  final StepRepositories stepRepositories;

  WeeklyProgressUsecase({required this.stepRepositories});

  Future<List<double>> call() async {
    final List<TodayDataEntity> weeklyData = await stepRepositories.getWeeklyData();
    final int stepGoal = CachedData.userPhysicalData.stepGoal;
    
    // Initialize a list of 7 days with 0.0, index 0 is Monday, index 6 is Sunday.
    final List<double> progressValues = List.filled(7, 0.0);

    for (var entity in weeklyData) {
      final int dayIndex = entity.date.weekday - 1; // 1 (Mon) to 7 (Sun) -> 0 to 6
      if (dayIndex >= 0 && dayIndex < 7) {
        progressValues[dayIndex] = entity.stepsCount / stepGoal;
      }
    }

    return progressValues;
  }
}
