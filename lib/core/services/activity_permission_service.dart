import 'package:permission_handler/permission_handler.dart';
import 'package:stridex/core/services/permission_handler.dart';

class ActivityPermissionService extends BasePermissionService {
  @override
  Permission get permission => Permission.activityRecognition;

}



