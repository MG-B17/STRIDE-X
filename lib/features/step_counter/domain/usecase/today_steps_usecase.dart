import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domain/repositories/step_repositories.dart';
import 'package:stridex/core/services/notification_service.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

class TodayStepsUsecase {
  final StepRepositories stepRepositories;
  final NotificationService notificationService;
  int _lastSavedSteps = 0 ;

  TodayStepsUsecase({
    required this.stepRepositories,
    required this.notificationService,
  });


  Stream<Either<Failure, int>> call({
    required TodayDataEntity initialTodayData,
    required int stepGoal,
    required double stepCorrectionFactor,
    required int baseline,
  }) async* {
    int currentBaseline = baseline;

    yield* stepRepositories.todaySteps().asyncMap((either) async {
      return await either.fold(
        (failure) {
          return left(failure);
        },
        (sensorSteps) async {
          
          if (!_isTheSameDay(day: initialTodayData.date)) {
            final resetResult = await _resetCounter(newBaseline: sensorSteps, currentTodayData: initialTodayData);
            initialTodayData = resetResult.value1;
            currentBaseline = resetResult.value2;
          }

          final steps = await _calculateTodayStep(
            sensorSteps: sensorSteps,
            baseline: currentBaseline,
          );

          final correctedSteps = _correctStep(
            steps: steps,
            stepCorrectionFactor: stepCorrectionFactor,
          );


          if (_isTimeToSave(
            lastSavedSteps:_lastSavedSteps,
            correctedSteps: correctedSteps
          )) {
            unawaited(stepRepositories.saveTodayData(todayData: initialTodayData));
            _lastSavedSteps = correctedSteps ;
          }
          _checkGoalNotification(correctedSteps, stepGoal);

          return right(correctedSteps);
        },
      );
    });
  }



  void _checkGoalNotification(int currentSteps, int stepGoal) {
    bool isNotificationsEnabled =
        CacheHelper.getData(key: AppKeys.isDailyReminderEnabled) ?? true;

    if (!isNotificationsEnabled) return;

    if (currentSteps >= stepGoal) {
      final todayStr = DateTime.now().toIso8601String().split('T')[0];
      final lastNotifiedDate =
          CacheHelper.getData(key: AppKeys.lastNotifiedGoalDate);

      if (lastNotifiedDate != todayStr) {
        notificationService.showGoalReachedNotification(steps: stepGoal);
        CacheHelper.saveData(
          key: AppKeys.lastNotifiedGoalDate,
          value: todayStr,
        );
      }
    }
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
    return (correctedSteps - lastSavedSteps) >= 50;
  }

  bool _isTheSameDay({required DateTime day}) {
    final now = DateTime.now();
    return day.year == now.year && day.month == now.month && day.day == now.day;
  }

  Future<Tuple2<TodayDataEntity, int>> _resetCounter({
    required int newBaseline,
    required TodayDataEntity currentTodayData,
  }) async {
    await stepRepositories.saveTodayData(todayData: currentTodayData);
    await stepRepositories.saveBaseline(baseline: newBaseline);

    final resetEntity = TodayDataEntity(
      stepsCount: 0,
      calories: 0,
      distance: 0,
      activeTimeSeconds: 0,
      date: DateTime.now(),
    );

    unawaited(stepRepositories.saveTodayData(todayData: resetEntity));

    return Tuple2(resetEntity, newBaseline);
  }
}



