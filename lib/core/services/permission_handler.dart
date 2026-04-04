import 'package:permission_handler/permission_handler.dart';
import 'package:stridex/core/constant/stride_enum.dart';

abstract class PermissionService {
  Future<PermissionStatusResult> request();
  Future<PermissionStatusResult> check();
  Future<void> openSettings();
  Future<bool> handlePermission({bool openSettingsIfPermanentlyDenied = true});
}



abstract class BasePermissionService implements PermissionService {
  Permission get permission;

  PermissionStatusResult mapStatus(PermissionStatus status) {
    if (status.isGranted) return PermissionStatusResult.granted;
    if (status.isPermanentlyDenied) return PermissionStatusResult.permanentlyDenied;
    if (status.isRestricted) return PermissionStatusResult.restricted;
    return PermissionStatusResult.denied;
  }

  @override
  Future<PermissionStatusResult> request() async {
    final status = await permission.request();
    return mapStatus(status);
  }

  @override
  Future<PermissionStatusResult> check() async {
    final status = await permission.status;
    return mapStatus(status);
  }

  @override
  Future<void> openSettings() async {
    await openAppSettings();
  }

  @override
  Future<bool> handlePermission({bool openSettingsIfPermanentlyDenied = true}) async {
    PermissionStatusResult status = await check();

    if (status == PermissionStatusResult.granted) return true;

    if (status == PermissionStatusResult.permanentlyDenied) {
      if (openSettingsIfPermanentlyDenied) await openSettings();
      return false;
    }
    
    status = await request();

    if (status == PermissionStatusResult.granted) return true;

    if (status == PermissionStatusResult.permanentlyDenied && openSettingsIfPermanentlyDenied) {
      await openSettings();
    }

    return false;
  }
}