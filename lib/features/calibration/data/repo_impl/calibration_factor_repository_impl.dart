import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/features/calibration/data/local_data/calibration_local_data.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';

class CalibrationRepositoryImpl implements CalibrationRepository {
  final CalibrationLocalData localData;
  CalibrationRepositoryImpl({required this.localData});

  @override
  Future<void> saveStepCorrection({required double stepCorrection}) async {
    await localData.saveStepCorrection(stepCorrection: stepCorrection);
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
      userData.stepGoal,
    );
  }

  @override
  Future<UserPhysicalData> getUserPhysicalData() async {
    final map = await localData.getUserPhysicalData();

    if (map == null) {
      throw Exception("User physical data not found");
    }

    final genderStr = map['gender'] as String?;

    final gender = Gender.values.firstWhere(
      (e) => e.name == genderStr,
      orElse: () => Gender.male,
    );

    return UserPhysicalData(
      strideLengthCm: map["strideLengthCm"] ?? 70,
      height: map['height'] ?? 170,
      weight: map['weight'] ?? 70,
      gender: gender,
      stepGoal: map['stepGoal'] ?? 2000,
    );
  }
}
