import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config.dart';

class LoginRepository {
  Future<Map<String, dynamic>?> validateDriver(String documento) async {
    final uri = Uri.parse("${AppConfig.apiUrl}?type=drivers&documento=$documento");
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception("Error HTTP ${res.statusCode}");
    }

    final data = json.decode(res.body);

    // Expect something like { "conductor_id": 1, "conductor": "Juan Perez" }
    if (data == null || data.isEmpty || data['conductor'] == null) {
      return null;
    }
    return data;
  }
}