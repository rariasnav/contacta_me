import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallHelper {
  static Future<void> makeEmergencyCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      throw("Error al realizar la llamada: $e");
    }
  }
}