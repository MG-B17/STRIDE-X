import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class TodayStepsUsecase {
  final StepRepositories stepRepositories;
  int _lastSaveSteps = -1;
  int _lastSaveActiveTime = -1;
  
  int? _lastProcessedSteps;
  DateTime? _lastStepTime;

  TodayStepsUsecase({required this.stepRepositories});

  Stream<Either<Failure, TodayDataEntity>> call() async* {
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

          _updateActiveTime(correctedSteps);


          CachedData.todayDataEntity = TodayDataEntity(
            stepsCount: correctedSteps,
            calories: CachedData.todayDataEntity.calories,
            distance: CachedData.todayDataEntity.distance,
            activeTimeSeconds: CachedData.todayDataEntity.activeTimeSeconds,
            date: CachedData.todayDataEntity.date,
          );

          if (_isTimeToSave(
            lastSavedSteps: _lastSaveSteps,
            correctedSteps: correctedSteps,
            lastSavedActiveTime: _lastSaveActiveTime,
            currentActiveTime: CachedData.todayDataEntity.activeTimeSeconds,
          )) {
            // Save full entity to safely persist active_time_seconds and steps
            unawaited(stepRepositories.saveTodayData(todayData: CachedData.todayDataEntity));
            _lastSaveSteps = correctedSteps;
            _lastSaveActiveTime = CachedData.todayDataEntity.activeTimeSeconds;
          }

          return right(CachedData.todayDataEntity);
        },
      );
    });
  }

  void _updateActiveTime(int currentSteps) {
    final now = DateTime.now();

    if (_lastProcessedSteps != null && _lastStepTime != null) {
      final int deltaSteps = currentSteps - _lastProcessedSteps!;
      final int timeDiffSeconds = now.difference(_lastStepTime!).inSeconds;

      if (deltaSteps > 0 && timeDiffSeconds > 0) {
        final double stepsPerSecond = deltaSteps / timeDiffSeconds;

        if (deltaSteps <= 20 && stepsPerSecond >= 0.5 && stepsPerSecond <= 3.5) {
          final int newActiveTime = CachedData.todayDataEntity.activeTimeSeconds + timeDiffSeconds;
          
          CachedData.todayDataEntity = TodayDataEntity(
            stepsCount: CachedData.todayDataEntity.stepsCount,
            calories: CachedData.todayDataEntity.calories,
            distance: CachedData.todayDataEntity.distance,
            activeTimeSeconds: newActiveTime,
            date: CachedData.todayDataEntity.date,
          );
        }
      }
    }

    _lastProcessedSteps = currentSteps;
    _lastStepTime = now;
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
    required int lastSavedActiveTime,
    required int currentActiveTime,
  }) {
    // Save every 10 steps OR if 30 seconds of active time have passed since last save
    final bool stepThresholdReached = (correctedSteps - lastSavedSteps).abs() >= 10;
    final bool activeTimeThresholdReached = (currentActiveTime - lastSavedActiveTime).abs() >= 30;
    
    return stepThresholdReached || activeTimeThresholdReached;
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
    _lastProcessedSteps = null;
    _lastStepTime = null;
    _lastSaveSteps = 0;
    _lastSaveActiveTime = 0;
    unawaited(
      stepRepositories.saveTodayData(todayData: CachedData.todayDataEntity),
    );
  }
}
