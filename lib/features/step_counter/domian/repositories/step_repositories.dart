import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';

abstract class StepRepositories {
  Stream<Either<Failure,int>> todaySteps ();

  Future<void> saveTodaySteps({required int steps});

  Future<int> getCachedTodaySteps();
}