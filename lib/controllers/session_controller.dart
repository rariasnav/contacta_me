import 'package:flutter/material.dart';

class SessionController {
  /// Realiza el cierre de sesión y redirige a la pantalla de login
  static void logout(BuildContext context) {
    // Aquí se puede agregar lógica adicional si se usa almacenamiento persistente
    // Ejemplo: limpiar SharedPreferences, tokens, etc.

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (Route<dynamic> route) => false,
    );
  }
}