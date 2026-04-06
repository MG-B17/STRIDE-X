import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';
import 'package:stridex/features/calibration/domain/usecase/calibrate_steps_usecase.dart';
import 'package:stridex/features/calibration/domain/usecase/calibration_stream_usecase.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_states.dart';
import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/usecase/save_user_physical_data_usecase.dart';

class CalibrationCubit extends Cubit<CalibrationState> {
  final CalibrateStepsUseCase calibrateUseCase;
  final CalibrationRepository calibrationRepository;
  final CalibrationStreamUsecase calibrationStreamUsecase;
  final SaveUserPhysicalDataUseCase saveUserPhysicalDataUseCase;

  static const int defaultCalibrationSteps = 10;

  int? initialSteps;
  int currentSteps = 0;
  Gender selectedGender = Gender.male;
  
  final TextEditingController heightController = TextEditingController(text: '170');
  final TextEditingController weightController = TextEditingController(text: '70');
  final TextEditingController stepGoalController = TextEditingController(text: '2000');

  static CalibrationCubit get(context) => BlocProvider.of(context);

  StreamSubscription<Either<Failure, int>>? subscription;

  CalibrationCubit({
    required this.calibrateUseCase,
    required this.calibrationRepository,
    required this.calibrationStreamUsecase,
    required this.saveUserPhysicalDataUseCase,
  }) : super(const CalibrationInitial());

  void selectGender(Gender gender) {
    selectedGender = gender;
    emit(SelectGender(gender: selectedGender));
  }

  Future<void> saveUserData({
    double? height,
    double? weight,
    Gender? gender,
    int? stepGoal,
  }) async {
    CalibrationData.userPhysicalData = UserPhysicalData(
      height: height ?? double.tryParse(heightController.text) !,
      weight: weight ?? double.tryParse(weightController.text) !,
      gender: gender ?? selectedGender,
      stepGoal: stepGoal ?? int.tryParse(stepGoalController.text) !,
    );
    await saveUserPhysicalDataUseCase(CalibrationData.userPhysicalData);
  }

  Future<void> finishCalibration() async {
    int detectedSteps = (initialSteps == null) ? 0 : currentSteps - initialSteps!;
    
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
      await calibrationRepository.saveStepCorrection(stepCorrection: entity.stepCorrection);
      emit(CalibrationSuccess(entity.stepCorrection));
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
    heightController.dispose();
    weightController.dispose();
    stepGoalController.dispose();
    return super.close();
  }
}
