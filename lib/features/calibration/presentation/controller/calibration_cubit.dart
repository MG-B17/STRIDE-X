import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
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
  bool isCalibrationComplete = false;
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
      // Temporarily emit failure to trigger the SnackBar
      emit(const CalibrationFailure(ErrorStrings.invalidStepCount));
      // Immediately revert to loading so the user can continue walking without losing the stream!
      emit(const CalibrationLoading());
      return;
    }

    emit(const CalibrationLoading());
    try {
      final entity = await calibrateUseCase.execute(
        realSteps: defaultCalibrationSteps,
        detectedSteps: detectedSteps,
      );
      debugPrint('Calibration factor: ${entity.factor}');
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
    
    if (await Permission.activityRecognition.request().isGranted) {
      subscription = calibrationStreamUsecase().listen((either) {
        either.fold(
          (failure) {
            isCalibrationComplete = false;
            emit(const CalibrationStreamFail(ErrorStrings.calibrationStreamError));
          },
          (stepCount) {
             initialSteps ??= stepCount;
             currentSteps = stepCount;
             
          },
        );
      });
    }
  }

  void resetCalibration() {
    isCalibrationComplete = false;
    initialSteps = null;
    currentSteps = 0;
    emit(const CalibrationInitial());
    startListening();
  }

  void stopListening() {
    subscription?.cancel();
    subscription = null;
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
