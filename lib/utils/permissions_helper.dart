import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  /// Solicita permisos de ubicación según la plataforma
  static Future<bool> requestLocationPermission() async {
    print('📍 Solicitando permiso de ubicación...');
    print('📱 Plataforma: ${Platform.isAndroid ? 'Android' : 'iOS'}');
    
    if (Platform.isAndroid) {
      final status = await Permission.location.request();
      print('📍 Android - Estado de ubicación: $status');
      return status.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.locationWhenInUse.request();
      print('📍 iOS - Estado de ubicación: $status');
      return status.isGranted;
    }
    print('❌ Plataforma no soportada');
    return false;
  }
  
  /// Solicita permisos de teléfono según la plataforma
  static Future<bool> requestPhonePermission() async {
    print('📞 Solicitando permiso de teléfono...');
    
    if (Platform.isAndroid) {
      final status = await Permission.phone.request();
      print('📞 Android - Estado de teléfono: $status');
      return status.isGranted;
    } else if (Platform.isIOS) {
      print('📞 iOS - Teléfono siempre permitido');
      return true;
    }
    print('❌ Plataforma no soportada');
    return false;
  }
  
  /// Solicita todos los permisos necesarios para la funcionalidad de emergencia
  static Future<bool> requestLocationAndPhonePermissions() async {
    print('🔐 Solicitando todos los permisos...');
    
    final locationOk = await requestLocationPermission();
    final phoneOk = await requestPhonePermission();
    
    print('📍 Ubicación OK: $locationOk');
    print('📞 Teléfono OK: $phoneOk');
    print('✅ Todos los permisos OK: ${locationOk && phoneOk}');
    
    return locationOk && phoneOk;
  }
  
  /// Verifica si los permisos ya están otorgados
  static Future<bool> checkLocationAndPhonePermissions() async {
    print('🔍 Verificando permisos actuales...');
    
    if (Platform.isAndroid) {
      final locationStatus = await Permission.location.status;
      final phoneStatus = await Permission.phone.status;
      print('📍 Android - Ubicación: $locationStatus');
      print('📞 Android - Teléfono: $phoneStatus');
      return locationStatus.isGranted && phoneStatus.isGranted;
    } else if (Platform.isIOS) {
      final locationStatus = await Permission.locationWhenInUse.status;
      print('📍 iOS - Ubicación: $locationStatus');
      print('📞 iOS - Teléfono: siempre permitido');
      return locationStatus.isGranted;
    }
    return false;
  }
  
  /// Verifica si se puede solicitar el permiso (no fue denegado permanentemente)
  static Future<bool> canRequestPermissions() async {
    print('🔍 Verificando si se pueden solicitar permisos...');
    
    if (Platform.isAndroid) {
      final locationStatus = await Permission.location.status;
      final phoneStatus = await Permission.phone.status;
      print('📍 Android - Ubicación puede solicitarse: ${!locationStatus.isPermanentlyDenied}');
      print('📞 Android - Teléfono puede solicitarse: ${!phoneStatus.isPermanentlyDenied}');
      return !locationStatus.isPermanentlyDenied && !phoneStatus.isPermanentlyDenied;
    } else if (Platform.isIOS) {
      final locationStatus = await Permission.locationWhenInUse.status;
      print('📍 iOS - Ubicación puede solicitarse: ${!locationStatus.isPermanentlyDenied}');
      return !locationStatus.isPermanentlyDenied;
    }
    return false;
  }
  
  /// Abre la configuración de la app si los permisos fueron denegados permanentemente
  static Future<void> openAppSettings() async {
    print('⚙️ Abriendo configuración de la app...');
    await openAppSettings();
  }
}