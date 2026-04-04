import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';

class GetUserPhysicalDataUseCase {
  final CalibrationRepository repository;

  GetUserPhysicalDataUseCase({required this.repository});

  Future<UserPhysicalData?> call() async {
    return await repository.getUserPhysicalData();
  }
}
