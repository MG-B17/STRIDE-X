import 'package:dartz/dartz.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';
import 'package:stridex/features/home/domain/repositories/step_repository.dart';

class GetStepsUsecase {
  final StepRepository repository;

  GetStepsUsecase({required this.repository});

  Stream<Either<Failure, StepCountEntity>> call(){
    return repository.getStepStream();
  }
}
