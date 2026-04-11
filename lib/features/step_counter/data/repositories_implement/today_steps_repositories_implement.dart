import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/exception.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/step_counter/data/local_data/baseline.dart';
import 'package:stridex/features/step_counter/data/local_data/sensor_step.dart';
import 'package:stridex/features/step_counter/data/local_data/today_steps.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class TodyStepsRepositoriesImplement extends StepRepositories {
  final BaselineLocalData baselineLocalData;
  final GetStepDataFormSensor getStepDataFormSensor;
  final TodayStepLocalData todayStepLocalData;

  TodyStepsRepositoriesImplement({
    required this.baselineLocalData,
    required this.getStepDataFormSensor,
    required this.todayStepLocalData,
  });

  @override
  Stream<Either<Failure, int>> todaySteps() {
    return getStepDataFormSensor
        .getStepsFromSensor()
        .map<Either<Failure, int>>((steps) => right(steps))
        .onErrorReturnWith((error, stackTrace) {
          if (error is PermissionDeniedException) {
            return left(
              PermissionDeniedFailure(ErrorStrings.permissionDeniedError),
            );
          } else {
            return left(ServerFailure(error.toString()));
          }
        });
  }

  @override
  Future<void> saveTodaySteps({required int steps}) async {
    await todayStepLocalData.saveTodaySteps(steps: steps);
  }

  @override
  Future<int> getCachedTodaySteps() async {
    await baselineLocalData.saveBaseline(steps: 0);
    return await todayStepLocalData.getTodaysteps();
  }

  @override
  Future<void> saveTodayData({required TodayDataEntity todayData}) async {
    await todayStepLocalData.saveTodayData(todayData: todayData);
  }
  
  @override
  Future<void> saveBaseline({required int baseline})async {
    await baselineLocalData.saveBaseline(steps:baseline);
  }

  @override
  Future<List<TodayDataEntity>> getWeeklyData() async {
    return await todayStepLocalData.getWeeklyData();
  }

  @override
  Future<List<TodayDataEntity>> getLastNDaysData(int days) async {
    return await todayStepLocalData.getLastNDaysData(days);
  }

  @override
  Future<List<TodayDataEntity>> getAllHistoricalData() async {
    return await todayStepLocalData.getAllHistoricalData();
  }
}
