import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_stream_repository.dart';

class CalibrationStreamUsecase {
  final CalibrationStreamRepository repository;

  CalibrationStreamUsecase({required this.repository});

  Stream<Either<Failure, int>> call() {
    return repository.getCalibrationStream();
  }

}



