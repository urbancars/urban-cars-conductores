import 'dart:convert';
import 'package:http/http.dart' as http;

/// Centralized HTTP client with DI-friendly baseUrl.
/// Supports both:
///   - legacy style:  api.get('balance', {'driverId': '1'})
///   - typed helpers: api.getBalance('1')
class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Uri _buildUri(String type, Map<String, String>? params) {
    final qp = <String, String>{'type': type};
    if (params != null) qp.addAll(params);
    return Uri.parse(baseUrl).replace(queryParameters: qp);
  }

  /// ✅ Generic GET to keep existing repositories working:
  /// Example:
  ///   final json = await api.get('balance', {'driverId': '1'});
  ///   final items = (json['balance'] as List?) ?? [];
  Future<Map<String, dynamic>> get(String type, Map<String, String> params) async {
    final uri = _buildUri(type, params);
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode} (${uri.toString()}): ${res.body}');
    }

    final decoded = json.decode(res.body);
    if (decoded is Map<String, dynamic>) return decoded;

    throw Exception('Unexpected response shape (expected JSON object): ${res.body}');
  }

  // ---------- Typed convenience methods (optional but nice) ----------

  Future<Map<String, dynamic>> getDriver(String documento) async {
    return await get('drivers', {'documento': documento});
  }

  Future<List<Map<String, dynamic>>> getReportes(String driverId, {int days = 14}) async {
    final m = await get('reportes', {'driverId': driverId, 'days': '$days'});
    final list = m['reportes'];
    if (list is List) {
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> getPagos(String driverId) async {
    final m = await get('pagos', {'driverId': driverId});
    final list = m['pagos'];
    if (list is List) {
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> getBalance(String driverId) async {
    final m = await get('balance', {'driverId': driverId});
    final list = m['balance'];
    if (list is List) {
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> getGoalBonus(String driverId) async {
    final m = await get('goal_bonus', {'driverId': driverId});
    final list = m['goal_bonus'];
    if (list is List) {
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> getReporteSemanal(String driverId) async {
    final m = await get('reporte_semanal', {'driverId': driverId});
    final list = m['reporte_semanal'];
    if (list is List) {
      return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }
}