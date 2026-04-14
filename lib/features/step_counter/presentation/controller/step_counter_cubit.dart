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

  StepCounterCubit({
    required this.todayStepsUsecase,
    required this.distanceAndCalUsecase,
    required this.weeklyProgressUsecase,
  }) : super(Initial());

  static StepCounterCubit get(context) => BlocProvider.of(context);

  StreamSubscription? _streamSubscription;

  final int _activeIndex = DateTime.now().weekday - 1;

  void startStepsStream() async {
    emit(Loading());
    List<double> weeklyValues = weeklyProgressUsecase(
      stepGoal: CachedData.userPhysicalData.stepGoal,
      weeklyData: CachedData.weeklyData,
    );
    _streamSubscription?.cancel();
    _streamSubscription =
        todayStepsUsecase(
          initialTodayData: CachedData.todayDataEntity,
          stepGoal: CachedData.userPhysicalData.stepGoal,
          stepCorrectionFactor:
              CachedData.stepsCalculationEntity.stepCorrectionFactor,
          baseline: CachedData.stepsCalculationEntity.baseline,
        ).listen((either) {
          either.fold((failure) => emit(Error(message: failure.message)), (
            steps,
          ) {
            final stepMatrixEntity = distanceAndCalUsecase(
              steps: steps,
              weight: CachedData.userPhysicalData.weight,
              strideLengthCm: CachedData.userPhysicalData.strideLengthCm!,
            );

            final double progress =
                (steps / CachedData.userPhysicalData.stepGoal);

            weeklyValues[_activeIndex] = progress;

            emit(
              Loaded(
                dailyStep: steps,
                goalStep: CachedData.userPhysicalData.stepGoal,
                progressStep: progress,
                calories: stepMatrixEntity.calories,
                distance: stepMatrixEntity.distance,
                activeTime: 0,
                weeklyValues: List.from(weeklyValues),
                activeIndex: _activeIndex,
              ),
            );
          });
        });
  }
}
