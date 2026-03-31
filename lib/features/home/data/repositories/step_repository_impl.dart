import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/core/utils/date_helper.dart';
import 'package:stridex/features/home/data/local_data/basline_local_data.dart';
import 'package:stridex/features/home/data/local_data/step_counter_local_data.dart';
import 'package:stridex/features/home/data/local_data/user_step_goal_local.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';
import 'package:stridex/features/home/domain/repositories/step_repository.dart';

class StepRepositoryImpl extends StepRepository {
  final BaslineLocalData baselineLocalData;
  final UserStepGoalLocal userStepGoalLocal;
  final StepCounterLocalData stepCounterLocalData;
  final DateHelper dateHelper;

  int? _cachedBaseline;
  int? _cachedGoal;
  int? _lastSavedSteps;
  DateTime? _lastSavedDate;

  StepRepositoryImpl({
    required this.baselineLocalData,
    required this.userStepGoalLocal,
    required this.stepCounterLocalData,
    required this.dateHelper,
  });

  @override
  Stream<Either<Failure, StepCountEntity>> getStepStream() {
    return Pedometer.stepCountStream.throttleTime(Duration(seconds: 1)).distinct((prev,next)=>prev.steps == next.steps).asyncMap((event) async {
      try {
        final steps = event.steps;

        final baseline = _cachedBaseline ??= await baselineLocalData.getBaseline();
        final goal = _cachedGoal ??= await userStepGoalLocal.getUserStepGoal();

        _lastSavedDate ??= await dateHelper.getTodayDate();
        final now = DateTime.now();

        if (!_isSameDay(now, _lastSavedDate!)) {
          await resetStepCounter(steps: steps, todayDate: now);
        }

        int dailySteps;

        if (_isSensorReset(steps, baseline)) {
          // Sensor reset scenario
          final savedTodayStep = await stepCounterLocalData.getTodaysteps();
          dailySteps = steps + savedTodayStep;
        } else {
          dailySteps = steps - baseline;

          if (_lastSavedSteps != steps) {
            _lastSavedSteps = steps;
            await stepCounterLocalData.saveTodaySteps(steps: steps);
          }
        }

        return Right(
          StepCountEntity(
            dailyStep: dailySteps,
            goalStep: goal,
            reachedDayStep: dailySteps / goal,
          ),
        );
      } catch (e) {
        return const Left(ServerFailure(ErrorStrings.serverError));
      }
    });
  }


  @override
  Future<void> resetStepCounter({required int steps, required DateTime todayDate}) async {
    try {
        await baselineLocalData.saveBaseline(steps: steps);
        await dateHelper.saveTodayDate(date: todayDate);
        await stepCounterLocalData.saveTodaySteps(steps: 0);
        _cachedBaseline = steps;
        _lastSavedSteps = 0; 
        _lastSavedDate = todayDate;  
    } catch (e) {
      debugPrint("Error resetting step counter: $e");
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isSensorReset(int steps, int baseline) {
    return steps < baseline;
  }
}