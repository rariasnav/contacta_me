import 'dart:io' show Platform;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class CallHelper {
  static Future<void> makeEmergencyCall(String phoneNumber) async {
    try {
      if (Platform.isAndroid) {
        await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      } else if (Platform.isIOS) {
        final uri = Uri(scheme: 'tel', path: phoneNumber);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw("No se puede realizar la llamada");
        }
      }
    } catch (e) {
      throw("Error al realizar la llamada: $e");
    }
  }
}