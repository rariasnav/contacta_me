import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = 'https://contactame-teleasistencia.com';

  static Future<Map<String, dynamic>> loginUser(String celular, String password) async {
    final url = Uri.parse('$_baseUrl/action/api_login.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'celular': celular, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'nombre': data['nombre'],
          'celular': data['celular'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Error de autenticación',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }    
  }
}