import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';
import 'package:stridex/features/step_counter/data/local_data/baseline.dart';
import 'package:stridex/features/step_counter/domian/entity/step_calculation_entity.dart';
import 'package:stridex/core/di/injection.dart' as di;

class CalibrationData {
  static late StepsCalculationEntity stepsCalculationEntity;
  static late UserPhysicalData userPhysicalData;

  static final BaselineLocalData _baselineLocalData = di
      .init<BaselineLocalData>();
  static final CalibrationRepository _calibrationRepository = di
      .init<CalibrationRepository>();   

  static Future<void> initCalibrationData() async {
    final results = await Future.wait([
      _calibrationRepository.getUserPhysicalData(),
      _baselineLocalData.getBaseline(),
      _calibrationRepository.getFactor(),
    ]);

    userPhysicalData = results[0] as UserPhysicalData;
    final baseline = results[1] as int;
    final stepCorrectionFactor = results[2] as double;

    stepsCalculationEntity = StepsCalculationEntity(
      baseline: baseline,
      stepCorrectionFactor: stepCorrectionFactor,
    );
  }

  static Future<void> updateCalibrationData({required double factor})async{
    stepsCalculationEntity.stepCorrectionFactor = factor;
  }
}
