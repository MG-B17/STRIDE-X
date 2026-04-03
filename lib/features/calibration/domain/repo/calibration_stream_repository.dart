import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';

abstract class CalibrationStreamRepository {
  Stream<Either<Failure, int>> getCalibrationStream();
}