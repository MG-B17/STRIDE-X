import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/features/calibration/data/local_data/calibration_local_data.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';

class CalibrationRepositoryImpl implements CalibrationRepository {
  final CalibrationLocalData localData;
  CalibrationRepositoryImpl({required this.localData});

  @override
  Future<void> saveStepCorrection({required double stepCorrection}) async {
    await localData.saveStepCorrection(stepCorrection:stepCorrection) ;
  }

  @override
  Future<double> getFactor() async {
    return await localData.getFactor();
  }

  @override
  Future<void> saveUserPhysicalData(UserPhysicalData userData) async {
    await localData.saveUserPhysicalData(
      userData.height,
      userData.weight,
      userData.gender.name,
      userData.strideLengthCm!,
    );
  }

  @override
  Future<UserPhysicalData?> getUserPhysicalData() async {
    final map = await localData.getUserPhysicalData();
    if (map != null) {
      return UserPhysicalData(
        strideLengthCm:map["strideLengthCm"] ,
        height: map['height'],
        weight: map['weight'],
        gender: Gender.values.byName(map['gender']),
      );
    }
    return null;
  }
}