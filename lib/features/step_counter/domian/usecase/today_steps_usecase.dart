import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class TodayStepsUsecase {
  final StepRepositories stepRepositories;
  int _lastSaveSteps = 0;

  TodayStepsUsecase({required this.stepRepositories});

  Stream<Either<Failure, int>> call() async* {
    yield* stepRepositories.todaySteps().asyncMap((either) async {
      return await either.fold(
        (failure) {
          return left(failure);
        },
        (sensorSteps) async {
          if (!_isTheSameDay(day: CachedData.todayDataEntity.date)) {
            _resetCounter(newBaseline: sensorSteps);
          }
          final steps = await _calculateTodayStep(
            sensorSteps: sensorSteps,
            baseline: CachedData.stepsCalculationEntity.baseline,
          );
          final correctedSteps = _correctStep(
            steps: steps,
            stepCorrectionFactor:
                CachedData.stepsCalculationEntity.stepCorrectionFactor,
          );
          if (_isTimeToSave(
            lastSavedSteps: _lastSaveSteps,
            correctedSteps: correctedSteps,
          )) {
            unawaited(stepRepositories.saveTodaySteps(steps: correctedSteps));
            _lastSaveSteps = correctedSteps;
          }

          return right(correctedSteps);
        },
      );
    });
  }


  Future<int> _calculateTodayStep({
    required int sensorSteps,
    required int baseline,
  }) async {
    if (_isSenseorReset(baseline: baseline, sensorSteps: sensorSteps)) {
      final cachedTodaysteps = await stepRepositories.getCachedTodaySteps();
      return cachedTodaysteps + sensorSteps;
    } else {
      return sensorSteps - baseline;
    }
  }


  int _correctStep({required int steps, required double stepCorrectionFactor}) {
    final int correctStep = (steps * stepCorrectionFactor).round();
    return correctStep;
  }


  bool _isSenseorReset({required int baseline, required int sensorSteps}) {
    return sensorSteps < baseline;
  }


  bool _isTimeToSave({
    required int lastSavedSteps,
    required int correctedSteps,
  }) {
    return (correctedSteps - lastSavedSteps) >= 100;
  }


  bool _isTheSameDay({required DateTime day}) {
    final now = DateTime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }


  Future<void> _resetCounter({required int newBaseline}) async {
    await stepRepositories.saveTodayData(todayData: CachedData.todayDataEntity);
    await stepRepositories.saveBaseline(baseline: newBaseline);
    CachedData.stepsCalculationEntity = CachedData.stepsCalculationEntity
        .copyWith(baseline: newBaseline);
    CachedData.todayDataEntity = TodayDataEntity(
      stepsCount: 0,
      calories: 0,
      distance: 0,
      activeTimeSeconds: 0,
      date: DateTime.now(),
    );
    unawaited(
      stepRepositories.saveTodayData(todayData: CachedData.todayDataEntity),
    );
  }
}
