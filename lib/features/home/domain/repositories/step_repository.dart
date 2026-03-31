import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';

abstract class StepRepository {
  Stream<Either<Failure, StepCountEntity>> getStepStream();

  Future<void> resetStepCounter({required int steps, required DateTime todayDate});
}