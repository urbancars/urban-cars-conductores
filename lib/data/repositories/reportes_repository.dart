import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config.dart';

class ReportesRepository {
  /// Fetch reportes for a given driverId with optional days filter
  Future<List<dynamic>> fetchReportes(String driverId, {int days = 14}) async {
    final uri = Uri.parse(
      "${AppConfig.apiUrl}?type=reportes&driverId=$driverId&days=$days",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded["reportes"] ?? [];
    } else {
      throw Exception("Failed to load reportes: ${response.statusCode}");
    }
  }
}