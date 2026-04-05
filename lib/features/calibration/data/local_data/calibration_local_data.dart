import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/services/step_database_helper.dart';
import 'package:stridex/core/utils/cache_helper.dart';

abstract class CalibrationLocalData {
  Future<void> saveStepCorrection({required double stepCorrection});
  Future<double> getFactor();
  
  Future<void> saveUserPhysicalData(double height, double weight, String gender, double strideLengthCm, int stepGoal);
  Future<Map<String, dynamic>?> getUserPhysicalData();
}

class CalibrationLocalDataImpl implements CalibrationLocalData {
  final DatabaseService databaseService;

  CalibrationLocalDataImpl({required this.databaseService});

  @override
  Future<void> saveStepCorrection({required double stepCorrection}) async {
    CacheHelper.saveData(key: AppKeys.calibrationStepCorrection, value: stepCorrection);
  }

  @override
  Future<double> getFactor() async {
    return CacheHelper.getData(key: AppKeys.calibrationStepCorrection) ?? 1.0;
  }

  @override
  Future<void> saveUserPhysicalData(double height, double weight, String gender, double strideLengthCm, int stepGoal) async {
    if (databaseService is StepDatabaseHelper) {
      await (databaseService as StepDatabaseHelper).saveUserData(height, weight, gender, strideLengthCm, stepGoal);
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserPhysicalData() async {
    if (databaseService is StepDatabaseHelper) {
      return await (databaseService as StepDatabaseHelper).getUserData();
    }
    return null;
  }
}
