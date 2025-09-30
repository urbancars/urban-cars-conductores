import 'package:shared_preferences/shared_preferences.dart';

class DriverSession {
  static const _driverIdKey = 'driverId';

  /// Get current driverId or null if missing
  static Future<String?> getDriverId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_driverIdKey);
  }

  /// Save driverId
  static Future<void> setDriverId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_driverIdKey, id);
  }

  /// Clear (logout)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_driverIdKey);
  }
}
