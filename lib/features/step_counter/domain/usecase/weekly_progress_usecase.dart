import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domain/repositories/step_repositories.dart';

class WeeklyProgressUsecase {
  final StepRepositories stepRepositories;

  WeeklyProgressUsecase({required this.stepRepositories});

  Future<List<double>> call({required int stepGoal}) async {
    final List<TodayDataEntity> weeklyData = await stepRepositories.getWeeklyData();
    
    final List<double> progressValues = List.filled(7, 0.0);

    for (var entity in weeklyData) {
      final int dayIndex = entity.date.weekday - 1; 
      if (dayIndex >= 0 && dayIndex < 7) {
        progressValues[dayIndex] = entity.stepsCount / stepGoal;
      }
    }

    return progressValues;
  }
}



