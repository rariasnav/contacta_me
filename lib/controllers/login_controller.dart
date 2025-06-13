import '../models/user_model.dart';
import '../services/api_service.dart';

class LoginController {
  static Future<Map<String, dynamic>> login(String celular, String password) async {
    if (celular.isEmpty || password.isEmpty) {
      return {
        'success': false,
        'message': 'Por favor complete todos los campos'
      };
    }

    final result = await ApiService.loginUser(celular, password);

    if (result['success']) {
      return {
        'success': true,
        'user': User.fromJson(result),
      };
    } else {
      return {
        'success': false,
        'message': result['message'] ?? 'Error de inicio de sesión',
      };
    }
  }
}