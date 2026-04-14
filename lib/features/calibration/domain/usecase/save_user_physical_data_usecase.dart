import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';

class SaveUserPhysicalDataUseCase {
  final CalibrationRepository repository;

  SaveUserPhysicalDataUseCase({required this.repository});

  Future<void> call(UserPhysicalData userData) async {

    final distanceCorrection = strideLengthCm(userData.height, userData.gender);
    
    return await repository.saveUserPhysicalData(
      UserPhysicalData(
        height: userData.height,
        weight: userData.weight,
        gender: userData.gender,
        strideLengthCm: distanceCorrection,
        stepGoal: userData.stepGoal
      ),
    );
  }

  double strideLengthCm(double heightCm, Gender gender) {
    double factor = gender == Gender.male ? 0.415 : 0.413;
    return heightCm * factor;
  }
}



