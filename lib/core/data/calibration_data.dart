import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';
import 'package:stridex/features/step_counter/data/local_data/baseline.dart';
import 'package:stridex/features/step_counter/data/local_data/today_steps.dart';
import 'package:stridex/features/step_counter/domain/entity/step_calculation_entity.dart';
import 'package:stridex/core/di/injection.dart' as di;
import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';

class CachedData {
  static late StepsCalculationEntity stepsCalculationEntity;
  static late UserPhysicalData userPhysicalData;
  static late TodayDataEntity todayDataEntity;

  static final BaselineLocalData _baselineLocalData = di
      .init<BaselineLocalData>();
  static final CalibrationRepository _calibrationRepository = di
      .init<CalibrationRepository>();

  static final TodayStepLocalData _todayStepLocalData = di
      .init<TodayStepLocalData>();

 static Future<void> initCalibrationData() async {
  final results = await Future.wait([
    _calibrationRepository.getUserPhysicalData(),
    _baselineLocalData.getBaseline(), 
    _todayStepLocalData.getTodayData(), 
    _calibrationRepository.getFactor(), 
  ]);

  userPhysicalData = results[0] as UserPhysicalData;
  final baseline = results[1] as int;
  final todayData = results[2] as TodayDataEntity;
  final stepCorrectionFactor = results[3] as double;

  stepsCalculationEntity = StepsCalculationEntity(
    baseline: baseline,
    stepCorrectionFactor: stepCorrectionFactor,
  );

  todayDataEntity = todayData;
}

  static Future<void> updateCalibrationData({required double factor}) async {
    stepsCalculationEntity.stepCorrectionFactor = factor;
  }
}



