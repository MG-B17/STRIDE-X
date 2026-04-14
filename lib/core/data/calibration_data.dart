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
  static late List<TodayDataEntity> weeklyData ;

  static final BaselineLocalData _baselineLocalData = di
      .init<BaselineLocalData>();
  static final CalibrationRepository _calibrationRepository = di
      .init<CalibrationRepository>();

  static final TodayStepLocalData _todayStepLocalData = di
      .init<TodayStepLocalData>();

 static Future<void> initCalibrationData() async {
  userPhysicalData =await _calibrationRepository.getUserPhysicalData();
  final baseline = await _baselineLocalData.getBaseline(); 
  final todayData = await _todayStepLocalData.getTodayData();
  final stepCorrectionFactor =await _calibrationRepository.getFactor();
  weeklyData =await _todayStepLocalData.getWeeklyData() ;
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



