import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/step_counter/domian/usecase/distance_and_cal_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/today_steps_usecase.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/core/data/calibration_data.dart';

class StepCounterCubit extends Cubit<StepCounterState> {
  final GetStepMatrix getStepMatrix;
  final TodayStepsUsecase todayStepsUsecase;

  StreamSubscription? _streamSubscription;

  StepCounterCubit({
    required this.todayStepsUsecase,
    required this.getStepMatrix,
  }) : super(Initial());

  static StepCounterCubit get(context) => BlocProvider.of(context);

  void startStepsStream() {
    emit(Loading());
    _streamSubscription?.cancel();
   _streamSubscription = todayStepsUsecase().listen((either) {
      either.fold((failure) => emit(Error(message: failure.message)), (steps) {
        final stepMatrixEntity = getStepMatrix(steps: steps);
        final int goal = CalibrationData.userPhysicalData.stepGoal;
        final double progress = (steps / goal);
        emit(
          Loaded(
            dailyStep: steps,
            goalStep: goal,
            progressStep: progress,
            calories: stepMatrixEntity.calories,
            distance: stepMatrixEntity.distance,
            activeTime: 10,
          ),
        );
      });
    });
  }
}
