import 'package:stridex/features/Calibration/domain/entity/calibration_factor_entity.dart';

abstract class CalibrateStepsUseCase {
  Future<CalibrationFactorEntity> execute({
    required int realSteps,
    required int detectedSteps,
  });
}

class CalibrateStepsUseCaseImpl implements CalibrateStepsUseCase {
  @override
  Future<CalibrationFactorEntity> execute({
    required int realSteps,
    required int detectedSteps,
  }) async {


    if (detectedSteps <= 0) return CalibrationFactorEntity(stepCorrection: 1.0);

    double stepCorrection = realSteps / detectedSteps ;

    stepCorrection = stepCorrection.clamp(0.5, 2.0);

    return CalibrationFactorEntity(stepCorrection: stepCorrection);
  }

}



