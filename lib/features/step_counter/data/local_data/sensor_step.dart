import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stridex/core/errors/exception.dart';
import 'package:stridex/core/services/activity_permission_service.dart';
import 'package:stridex/features/step_counter/data/local_data/today_steps.dart';

abstract class GetStepDataFormSensor {
  Stream<int> getStepsFromSensor();
}

class GetStepDataFormSensorImpl extends GetStepDataFormSensor {
  final ActivityPermissionService activityPermissionService;
  final TodayStepLocalData todayStepLocalData;

  GetStepDataFormSensorImpl({required this.activityPermissionService,required this.todayStepLocalData});

  @override
  Stream<int> getStepsFromSensor() async* {
    final permissionResult = await activityPermissionService.handlePermission();

    if (!permissionResult) {
      throw PermissionDeniedException();
    }

   yield* Pedometer.stepCountStream
        .throttleTime(const Duration(seconds: 1))
        .distinct()
        .map((event) => event.steps);
  }
}
