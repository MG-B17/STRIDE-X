import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domain/repositories/step_repositories.dart';

class GetTodayDataUseCase {
  final StepRepositories stepRepositories;

  GetTodayDataUseCase({required this.stepRepositories});

  Future<TodayDataEntity> call() async {
    return await stepRepositories.getTodayData();
  }
}
