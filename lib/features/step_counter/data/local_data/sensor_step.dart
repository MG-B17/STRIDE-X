import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/exception.dart';
import 'package:stridex/core/services/activity_premssion_service.dart';

abstract class GetStepDataFormSensor {
  Stream<int> getStepsFromSensor();
}

class GetStepDataFormSensorImpl extends GetStepDataFormSensor {
  final ActivityPremssionService activityPremssionService;

  GetStepDataFormSensorImpl({required this.activityPremssionService});

  @override
  Stream<int> getStepsFromSensor() async* {
    final permissionResult = await activityPremssionService.handlePermission();

    if (!permissionResult) {
      throw PermissionDeniedException();
    }

    yield* Pedometer.stepCountStream
        .throttleTime(const Duration(seconds: 1))
        .map((event) => event.steps)
        .distinct();
  }
}
