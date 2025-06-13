import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<bool> requestLocationAndPhonePermissions() async {
    final locationStatus = await Permission.location.request();
    final phoneStatus = await Permission.phone.request();

    return locationStatus.isGranted && phoneStatus.isGranted;
  }
}