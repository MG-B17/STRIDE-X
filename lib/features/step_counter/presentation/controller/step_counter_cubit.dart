import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/step_counter/domain/usecase/distance_and_cal_usecase.dart';
import 'package:stridex/features/step_counter/domain/usecase/today_steps_usecase.dart';
import 'package:stridex/features/step_counter/domain/usecase/weekly_progress_usecase.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/core/data/calibration_data.dart';

class StepCounterCubit extends Cubit<StepCounterState> {
  final DistanceAndCalUsecase distanceAndCalUsecase;
  final TodayStepsUsecase todayStepsUsecase;
  final WeeklyProgressUsecase weeklyProgressUsecase;

  StreamSubscription? _streamSubscription;

  StepCounterCubit({
    required this.todayStepsUsecase,
    required this.distanceAndCalUsecase,
    required this.weeklyProgressUsecase,
  }) : super(Initial());

  static StepCounterCubit get(context) => BlocProvider.of(context);

  void startStepsStream() async {
    emit(Loading());
    _streamSubscription?.cancel();

    final stepGoal = CachedData.userPhysicalData.stepGoal;
    final weight = CachedData.userPhysicalData.weight;
    final strideLengthCm = CachedData.userPhysicalData.strideLengthCm!;
    final stepCorrectionFactor = CachedData.stepsCalculationEntity.stepCorrectionFactor;
    final baseline = CachedData.stepsCalculationEntity.baseline;
    
    List<double> weeklyValues = await weeklyProgressUsecase(stepGoal: stepGoal);
    int activeIndex = DateTime.now().weekday - 1;

    _streamSubscription = todayStepsUsecase(
      initialTodayData: CachedData.todayDataEntity,
      stepGoal: stepGoal,
      stepCorrectionFactor: stepCorrectionFactor,
      baseline: baseline,
    ).listen((either) {
      either.fold((failure) => emit(Error(message: failure.message)), (todayData) {
        final int steps = todayData.stepsCount;
        
        final stepMatrixEntity = distanceAndCalUsecase(
          steps: steps,
          weight: weight,
          strideLengthCm: strideLengthCm,
        );
        
        final double progress = (steps / stepGoal);
        final int activeMinutes = todayData.activeTimeSeconds ~/ 60;
        
        weeklyValues[activeIndex] = progress;

        emit(
          Loaded(
            dailyStep: steps,
            goalStep: stepGoal,
            progressStep: progress,
            calories: stepMatrixEntity.calories,
            distance: stepMatrixEntity.distance,
            activeTime: activeMinutes,
            weeklyValues: List.from(weeklyValues),
            activeIndex: activeIndex,
          ),
        );
      });
    });
  }
}



