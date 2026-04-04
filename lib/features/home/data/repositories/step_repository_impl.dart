import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/core/services/activity_premssion_service.dart';
import 'package:stridex/core/utils/date_helper.dart';
import 'package:stridex/features/calibration/data/local_data/calibration_local_data.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/home/data/local_data/baseline_local_data.dart';
import 'package:stridex/features/home/data/local_data/step_counter_local_data.dart';
import 'package:stridex/features/home/data/local_data/user_step_goal_local.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';
import 'package:stridex/features/home/domain/repositories/step_repository.dart';

class StepRepositoryImpl extends StepRepository {
  final BaselineLocalData baselineLocalData;
  final UserStepGoalLocal userStepGoalLocal;
  final StepCounterLocalData stepCounterLocalData;
  final CalibrationLocalData calibrationLocalData;
  final DateHelper dateHelper;
  final ActivityPremssionService activityPremssionService;

  int? _cachedBaseline;
  int? _cachedGoal;
  int? _lastSavedSteps;
  DateTime? _lastSavedDate;
  int? _totalActiveSeconds;
  DateTime? _lastStepTime;
  int? _lastRawSteps;

  StepRepositoryImpl({
    required this.baselineLocalData,
    required this.userStepGoalLocal,
    required this.stepCounterLocalData,
    required this.dateHelper,
    required this.activityPremssionService,
    required this.calibrationLocalData,
  });

  @override
  Stream<Either<Failure, StepCountEntity>> getStepStream() async* {
    final permissionResult = await activityPremssionService.handlePermission();
    if (!permissionResult) {
      yield left(PermissionDeniedFailure(ErrorStrings.permissionDeniedError));
      return;
    }

    // Fetch user data once for use in calculation stream
    final userDataMap = await calibrationLocalData.getUserPhysicalData();
    final double weight = userDataMap?['weight'] ?? 70.0;
    final double strideLength = userDataMap?['strideLengthCm'] ?? 70.0;

    yield* Pedometer.stepCountStream
        .throttleTime(const Duration(seconds: 1))
        .distinct((prev, next) => prev.steps == next.steps)
        .asyncMap((event) async {
          try {
            if (_totalActiveSeconds == null) {
              final data = await stepCounterLocalData.getTodayData();
              _totalActiveSeconds = data['active_time_seconds'] as int? ?? 0;
            }

            final double factor = await calibrationLocalData.getFactor();
            final int rawSteps = event.steps;
            final now = DateTime.now();

            // Calculate Active Time: If steps are taken within 10s of each other, count it as active duration
            if (_lastRawSteps != null && rawSteps > _lastRawSteps!) {
              if (_lastStepTime != null) {
                final diff = now.difference(_lastStepTime!);
                if (diff.inSeconds > 0 && diff.inSeconds < 10) {
                  _totalActiveSeconds =
                      (_totalActiveSeconds ?? 0) + diff.inSeconds;
                }
              }
              _lastStepTime = now;
            }
            _lastRawSteps = rawSteps;

            final baseline =
                _cachedBaseline ??= await baselineLocalData.getBaseline();
            final goal =
                _cachedGoal ??= await userStepGoalLocal.getUserStepGoal();
            _lastSavedDate ??= await dateHelper.getTodayDate();

            if (!_isSameDay(now, _lastSavedDate!)) {
              await resetStepCounter(steps: rawSteps, todayDate: now);
            }

            int dailySteps;

            if (_isSensorReset(rawSteps, baseline)) {
              final savedTodayStep = await stepCounterLocalData.getTodaysteps();
              int newStepsSinceReboot = (rawSteps * factor).round();
              dailySteps = savedTodayStep + newStepsSinceReboot;
            } else {
              // Standard relative calculation
              int relativeSteps = rawSteps - baseline;
              dailySteps = (relativeSteps * factor).round();

              if (_lastSavedSteps != dailySteps) {
                _lastSavedSteps = dailySteps;

                // Accurate calculations
                final distance = (dailySteps * strideLength) / 100000; // km
                final calories = dailySteps * weight * 0.00057;

                await stepCounterLocalData.saveTodaySteps(
                  steps: dailySteps,
                  calories: calories,
                  distance: distance,
                  activeTime: _totalActiveSeconds,
                );
              }
            }

            // Accurate calculations for entity
            final distance = (dailySteps * strideLength) / 100000; // km
            final calories = dailySteps * weight * 0.00057;

            return Right(
              StepCountEntity(
                dailyStep: dailySteps,
                goalStep: goal,
                reachedDayStep: dailySteps / goal,
                calories: calories,
                distance: distance,
                activeTime: (_totalActiveSeconds ?? 0) ~/ 60,
              ),
            );
          } catch (e) {
            return const Left(ServerFailure(ErrorStrings.serverError));
          }
        });
  }

  @override
  Future<Either<Failure, UserPhysicalData>> getUserPhysicalData() async {
    try {
      final map = await calibrationLocalData.getUserPhysicalData();
      if (map != null) {
        return Right(
          UserPhysicalData(
            strideLengthCm: map["strideLengthCm"],
            height: map['height'],
            weight: map['weight'],
            gender: Gender.values.byName(map['gender']),
          ),
        );
      }
      return const Left(CacheFailure("No user data found"));
    } catch (e) {
      return const Left(ServerFailure(ErrorStrings.serverError));
    }
  }


  @override
  Future<void> resetStepCounter({required int steps, required DateTime todayDate}) async {
    try {
        await baselineLocalData.saveBaseline(steps: steps);
        await dateHelper.saveTodayDate(date: todayDate);
        await stepCounterLocalData.saveTodaySteps(steps: 0, calories: 0, distance: 0, activeTime: 0);
        _cachedBaseline = steps;
        _lastSavedSteps = 0; 
        _totalActiveSeconds = 0;
        _lastStepTime = null;
        _lastRawSteps = null;
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