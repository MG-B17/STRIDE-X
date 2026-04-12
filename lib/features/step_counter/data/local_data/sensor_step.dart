import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/exception.dart';
import 'package:stridex/core/services/activity_permission_service.dart';

abstract class GetStepDataFormSensor {
  Stream<int> getStepsFromSensor();
}

class GetStepDataFormSensorImpl extends GetStepDataFormSensor {
  final ActivityPermissionService activityPermissionService;

  GetStepDataFormSensorImpl({required this.activityPermissionService});

  @override
  Stream<int> getStepsFromSensor() async* {
    final permissionResult = await activityPermissionService.handlePermission();

    if (!permissionResult) {
      throw PermissionDeniedException();
    }

    yield* Pedometer.stepCountStream
        .throttleTime(const Duration(seconds: 1))
        .map((event) => event.steps)
        .distinct();
  }
}