import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';

abstract class CalibrationRepository {
  Future<void> saveStepCorrection({required double stepCorrection});
  Future<double> getFactor();
  
  Future<void> saveUserPhysicalData(UserPhysicalData userData);
  Future<UserPhysicalData?> getUserPhysicalData();
}