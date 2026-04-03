import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

abstract class CalibrationLocalData {
  Future<void> saveFactor(double factor);
  Future<double> getFactor();
}

class CalibrationLocalDataImpl implements CalibrationLocalData {


  @override
  Future<void> saveFactor(double factor) async {
    CacheHelper.saveData(key: AppKeys.calibrationFactorKey, value: factor);
  }

  @override
  Future<double> getFactor() async {
    return CacheHelper.getData(key: AppKeys.calibrationFactorKey) ?? 1.0;
  }
}
