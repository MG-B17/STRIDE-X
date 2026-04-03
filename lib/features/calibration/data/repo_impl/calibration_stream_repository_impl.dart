import 'package:dartz/dartz.dart';
import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_stream_repository.dart';

class CalibrationStreamRepositoryImpl extends CalibrationStreamRepository{

  @override
  Stream<Either<Failure, int>> getCalibrationStream() {
    return Pedometer.stepCountStream
      .throttleTime(const Duration(seconds: 1))
      .distinct((prev, next) => prev.steps == next.steps)
      .map<Either<Failure, int>>((event) => Right(event.steps))
      .onErrorReturn(const Left(ServerFailure(ErrorStrings.serverError)));
  }
}