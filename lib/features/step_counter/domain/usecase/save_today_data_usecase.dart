import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domain/repositories/step_repositories.dart';

class SaveTodayDataUseCase {
  final StepRepositories stepRepositories;

  SaveTodayDataUseCase({required this.stepRepositories});

  Future<void> call(TodayDataEntity todayData) async {
    await stepRepositories.saveTodayData(todayData: todayData);
  }
}
