import 'package:dartz/dartz.dart';
import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/error_strings.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/core/services/activity_premssion_service.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_stream_repository.dart';

class CalibrationStreamRepositoryImpl extends CalibrationStreamRepository {
  final ActivityPremssionService activityPremssionService;

  CalibrationStreamRepositoryImpl({required this.activityPremssionService});

  @override
  Stream<Either<Failure, int>> getCalibrationStream() async* {
    final hasPermission = await activityPremssionService.handlePermission();
    if (!hasPermission) {
      yield left(PermissionDeniedFailure(ErrorStrings.permissionDeniedError));
      return;
    }
    try {
      yield* Pedometer.stepCountStream
          .throttleTime(const Duration(seconds: 1))
          .distinct((prev, next) => prev.steps == next.steps)
          .map<Either<Failure, int>>((event) => Right(event.steps))
          .take(30)
          .onErrorReturn(const Left(ServerFailure(ErrorStrings.serverError)));
    } catch (e) {
      yield const Left(ServerFailure(ErrorStrings.serverError));
    }
  }
}
