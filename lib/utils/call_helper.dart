import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:io';

class CallHelper {
  /// Realiza una llamada de emergencia al número especificado
  static Future<bool> makeEmergencyCall(String phoneNumber) async {
    try {
      // Validar el número de teléfono
      if (phoneNumber.isEmpty) {
        throw 'Número de teléfono no válido';
      }

      if (Platform.isAndroid) {
        // Android: llamada directa
        bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
        if (res == null || res == false) {
          throw 'No se pudo realizar la llamada directa en Android';
        }
        return true;
      } else if (Platform.isIOS) {
        // iOS: se abre el marcador (el usuario debe presionar para llamar)
        final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
        if (await canLaunchUrl(phoneUri)) {
          final bool launched = await launchUrl(
            phoneUri,
            mode: LaunchMode.externalApplication,
          );
          if (!launched) {
            throw 'No se pudo abrir el marcador en iOS';
          }
          return true;
        } else {
          throw 'El dispositivo iOS no puede manejar el URI tel:';
        }
      } else {
        throw 'Plataforma no soportada para llamadas';
      }
    } catch (e) {
      print('Error al realizar la llamada: $e');
      return false;
    }
  }

  /// Verifica si el dispositivo puede hacer llamadas
  static Future<bool> canMakeCall() async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: '');
      return await canLaunchUrl(phoneUri);
    } catch (e) {
      print('Error al verificar capacidad de llamada: $e');
      return false;
    }
  }

  /// Abre la app de teléfono con el número prellenado (sin llamar automáticamente)
  static Future<bool> openDialer(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

      if (await canLaunchUrl(phoneUri)) {
        return await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      print('Error al abrir marcador: $e');
      return false;
    }
  }
}
