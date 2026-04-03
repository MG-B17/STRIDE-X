import 'package:stridex/features/calibration/data/local_data/calibration_local_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';

class CalibrationRepositoryImpl implements CalibrationRepository {
  final CalibrationLocalData localData;
  CalibrationRepositoryImpl({required this.localData});

  @override
  Future<void> saveFactor({required double factor}) async {
    await localData.saveFactor(factor);
  }

  @override
  Future<double> getFactor() async {
    return await localData.getFactor();
  }
}