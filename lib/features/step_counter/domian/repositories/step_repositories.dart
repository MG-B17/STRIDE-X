import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';

abstract class StepRepositories {
  Stream<Either<Failure, int>> todaySteps();

  Future<void> saveTodaySteps({required int steps});

  Future<void> saveTodayData({required TodayDataEntity todayData});

  Future<int> getCachedTodaySteps();

  Future<void> saveBaseline({required int baseline});

  Future<List<TodayDataEntity>> getWeeklyData();
  Future<List<TodayDataEntity>> getLastNDaysData(int days);
  Future<List<TodayDataEntity>> getAllHistoricalData();
}
