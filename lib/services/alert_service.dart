import 'dart:convert';
import 'package:http/http.dart' as http;

class AlertService {
  static Future<Map<String, dynamic>> sendAlert({
    required String color,
    required String celular,
    required double latitud,
    required double longitud,
  }) async {
    final url = Uri.parse("https://contactame-teleasistencia.com/action/api_alerta.php");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'color': color,
        'celular': celular,
        'latitud': latitud.toString(),
        'longitud': longitud.toString(),
      }),
    );

    final data = jsonDecode(response.body);
    return {
      "success": data['status'] == true,
      "message": data['message'] ?? "Respuesta desconocida"
    };
  }
}