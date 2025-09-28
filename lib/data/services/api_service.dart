import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config.dart';

class ApiService {
  final String baseUrl = AppConfig.apiUrl;

  Future<List<dynamic>> fetchData(String type, String driverId) async {
    final uri = Uri.parse("$baseUrl?type=$type&driver_id=$driverId");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // Return list for the specific type (e.g., "pagos", "balance", etc.)
      return json[type] ?? [];
    } else {
      throw Exception("Failed to fetch $type: ${response.statusCode}");
    }
  }
}