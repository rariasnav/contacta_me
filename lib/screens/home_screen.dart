import 'package:flutter/material.dart';
import 'package:contacta_me/models/user_model.dart';
import 'package:contacta_me/controllers/session_controller.dart';
import 'package:contacta_me/services/alert_service.dart';
import 'package:contacta_me/utils/location_helper.dart';
import 'package:contacta_me/utils/permissions_helper.dart';
import 'package:contacta_me/utils/call_helper.dart';
import '../widgets/info_line.dart';
import '../widgets/emergency_button.dart';
import '../widgets/help_button.dart';
import '../widgets/logout_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  void _showMessage(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void _handleEmergencyAlert(User user) async {
  if (!mounted) return;

  try {        
    // Solicitar permisos
    final permisosOk = await PermissionsHelper.requestLocationAndPhonePermissions();
    
    if (!mounted || !permisosOk) {
      _showMessage("Se requieren permisos para continuar");
      return;
    }

    // Obtener ubicación actual
    _showMessage("Obteniendo ubicación...", success: true);
    final location = await LocationHelper.getCurrentLocation();
    
    if (!mounted || location == null) {
      _showMessage("No se pudo obtener ubicación");
      return;
    }

    // Enviar alerta
    _showMessage("Enviando alerta de emergencia...", success: true);
    final result = await AlertService.sendAlert(
      color: 'Roja',
      celular: user.celular,
      latitud: location.latitude,
      longitud: location.longitude,
    );

    if (!mounted) return;
    
    // Mostrar resultado de la alerta
    _showMessage(
      result['message'],
      success: result['success'],
    );

    // Realizar llamada de emergencia si la alerta fue exitosa
    if (result['success']) {
      _showMessage("Realizando llamada de emergencia...", success: true);
      
      final callSuccess = await CallHelper.makeEmergencyCall("6053225178");
      
      if (!mounted) return;
      
      if (!callSuccess) {
        _showMessage("Error al realizar la llamada de emergencia");
      }
    }
  } catch (e) {
    if (!mounted) return;
    _showMessage("Error en alerta de emergencia: $e");
  }
}

  bool _redirected = false;

  void _redirectIfInvalidArgs() {
    if (_redirected) return;
    _redirected = true;

    Future.microtask(() {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! User) {
      _redirectIfInvalidArgs();
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final User user = args;

    return Scaffold(
      backgroundColor: const Color(0xFFEAE9E7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoLine(label: "Nombre:", value: user.nombre),
              InfoLine(label: "Teléfono:", value: user.celular),
              InfoLine(label: "Dispositivo:", value: "Aplicación Móvil"),
              const SizedBox(height: 32),

              Center(
                child: Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5F6),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        blurRadius: 5,
                        offset: const Offset(2, 4),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "TeleAsistencia",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFD90909),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      EmergencyButton(
                        onPressed: () => _handleEmergencyAlert(user),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Botón de ayuda
              HelpButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("¿Cómo funciona el botón?"),
                      content: const Text(
                        "Al presionar el botón de alerta se enviará tu ubicación y se hará una llamada de emergencia.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Entendido"),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              LogoutButton(
                onPressed: () {
                  SessionController.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}