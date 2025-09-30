import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> getDriver(String documento) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=drivers&documento=$documento'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('driver')) {
        if (data['driver'] == null) {
          // ✅ handle not found properly
          throw Exception("Documento no encontrado");
        }
        return Map<String, dynamic>.from(data['driver']);
      } else {
        throw Exception("Unexpected response shape for driver: $data");
      }
    } else {
      throw Exception('No se pudo conectar al servidor');
    }
  }

  Future<List<Map<String, dynamic>>> getReportes(
    String driverId, {
    int days = 7,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=reportes&driverId=$driverId&days=$days'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('reportes')) {
        return List<Map<String, dynamic>>.from(data['reportes']);
      } else {
        throw Exception("Unexpected response shape for reportes: $data");
      }
    } else {
      throw Exception('Failed to load reportes');
    }
  }

  Future<List<Map<String, dynamic>>> getPagos(String driverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=pagos&driverId=$driverId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('pagos')) {
        return List<Map<String, dynamic>>.from(data['pagos']);
      } else {
        throw Exception("Unexpected response shape for pagos: $data");
      }
    } else {
      throw Exception('Failed to load pagos');
    }
  }

  Future<List<Map<String, dynamic>>> getBalance(String driverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=balance&driverId=$driverId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('balance')) {
        return List<Map<String, dynamic>>.from(data['balance']);
      } else {
        throw Exception("Unexpected response shape for balance: $data");
      }
    } else {
      throw Exception('Failed to load balance');
    }
  }

  Future<List<Map<String, dynamic>>> getGoalBonus(String driverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=goal_bonus&driverId=$driverId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('goal_bonus')) {
        return List<Map<String, dynamic>>.from(data['goal_bonus']);
      } else {
        throw Exception("Unexpected response shape for goal_bonus: $data");
      }
    } else {
      throw Exception('Failed to load goal_bonus');
    }
  }

  Future<List<Map<String, dynamic>>> getReporteSemanal(String driverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type=reporte_semanal&driverId=$driverId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map && data.containsKey('reporte_semanal')) {
        return List<Map<String, dynamic>>.from(data['reporte_semanal']);
      } else {
        throw Exception("Unexpected response shape for reporte_semanal: $data");
      }
    } else {
      throw Exception('Failed to load reporte_semanal');
    }
  }
}
