import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  
  /// Request Activity Recognition Permission
  static Future<bool> requestActivityRecognition() async {
    final status = await Permission.activityRecognition.request();
    return status.isGranted;
  }

  /// Check Activity Recognition Permission without requesting
  static Future<bool> isActivityRecognitionGranted() async {
    final status = await Permission.activityRecognition.status;
    return status.isGranted;
  }

  /// Handle full flow (request + settings if permanently denied)
  static Future<bool> handleActivityRecognitionPermission() async {
    final status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }
}