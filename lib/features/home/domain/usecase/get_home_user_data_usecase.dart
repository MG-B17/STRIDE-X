import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/home/domain/repositories/step_repository.dart';

class GetHomeUserDataUseCase {
  final StepRepository repository;

  GetHomeUserDataUseCase({required this.repository});

  Future<Either<Failure, UserPhysicalData>> call() async {
    return await repository.getUserPhysicalData();
  }
}
