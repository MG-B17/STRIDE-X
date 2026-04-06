import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/step_counter/domian/usecase/active_time_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/distance_and_cal_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/today_steps_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/weekly_progress_usecase.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/core/data/calibration_data.dart';

class StepCounterCubit extends Cubit<StepCounterState> {
  final GetStepMatrix getStepMatrix;
  final TodayStepsUsecase todayStepsUsecase;
  final WeeklyProgressUsecase weeklyProgressUsecase;
  final ActiveTimeUsecase activeTimeUsecase;

  StreamSubscription? _streamSubscription;

  StepCounterCubit({
    required this.todayStepsUsecase,
    required this.getStepMatrix,
    required this.weeklyProgressUsecase,
    required this.activeTimeUsecase,
  }) : super(Initial());

  static StepCounterCubit get(context) => BlocProvider.of(context);

  void startStepsStream() async {
    emit(Loading());
    _streamSubscription?.cancel();
    
    List<double> weeklyValues = await weeklyProgressUsecase();
    int activeIndex = DateTime.now().weekday - 1;

   _streamSubscription = todayStepsUsecase().listen((either) {
      either.fold((failure) => emit(Error(message: failure.message)), (steps) {
        final stepMatrixEntity = getStepMatrix(steps: steps);
        final int goal = CachedData.userPhysicalData.stepGoal;
        final double progress = (steps / goal);
        
        final int activeMinutes = activeTimeUsecase(steps: steps);
        
        weeklyValues[activeIndex] = progress;

        emit(
          Loaded(
            dailyStep: steps,
            goalStep: goal,
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
