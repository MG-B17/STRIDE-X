import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';
import 'package:stridex/features/calibration/domain/usecase/calibrate_steps_usecase.dart';
import 'package:stridex/features/calibration/domain/usecase/calibration_stream_usecase.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_states.dart';

class CalibrationCubit extends Cubit<CalibrationState> {
  final CalibrateStepsUseCase calibrateUseCase;
  final CalibrationRepository calibrationRepository;
  final CalibrationStreamUsecase calibrationStreamUsecase;

  static const int defaultCalibrationSteps = 10;

  int? initialSteps;
  int currentSteps = 0;

  static CalibrationCubit get(context) => BlocProvider.of(context);

  StreamSubscription<Either<Failure, int>>? subscription;

  CalibrationCubit({
    required this.calibrateUseCase,
    required this.calibrationRepository,
    required this.calibrationStreamUsecase,
  }) : super(const CalibrationInitial());

  Future<void> finishCalibration() async {
    int detectedSteps = (initialSteps == null) ? 0 : currentSteps - initialSteps!;
    debugPrint('Initial Steps: $initialSteps, Current Steps: $currentSteps, Detected Steps: $detectedSteps');
    
    if (detectedSteps <= 0) {
      emit(const CalibrationFailure(ErrorStrings.invalidStepCount));
      emit(const CalibrationLoading());
      return;
    }

    emit(const CalibrationLoading());
    try {
      final entity = await calibrateUseCase.execute(
        realSteps: defaultCalibrationSteps,
        detectedSteps: detectedSteps,
      );
      await calibrationRepository.saveFactor(factor: entity.factor);
      emit(CalibrationSuccess(entity.factor));
      stopListening();
    } catch (e) {
      stopListening();
      emit(const CalibrationFailure(AppStrings.calibrationFail));
    }
  }

  void startListening() async {
    stopListening();
    emit(const CalibrationLoading());
    initialSteps = null;
    currentSteps = 0;
    subscription = calibrationStreamUsecase().listen((either) {
      either.fold(
        (failure) {
          emit(CalibrationStreamFail(failure.message));
        },
        (stepCount) {
          if (initialSteps == null) {
            initialSteps = stepCount;
            currentSteps = stepCount;
          } else {
            currentSteps = stepCount;
          }
          final int detected = currentSteps - initialSteps!;
          emit(CalibrationStreamSuccess(detected));
        },
      );
    });

  }

  void resetCalibration() {
    initialSteps = null;
    currentSteps = 0;
    emit(const CalibrationInitial());
  }

  void stopListening() {
    subscription?.cancel();
    subscription = null;
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    resetCalibration();
    return super.close();
  }
}
