import '../../data/services/api_service.dart';
import '../../bloc/login/login_state.dart';

class LoginRepository {
  final ApiService api;

  LoginRepository(this.api);

  Future<Driver> login(String documento) async {
    final data = await api.getDriver(documento);
    if (data.isEmpty || data['conductor_id'] == null) {
      throw Exception("Conductor no encontrado");
    }
    return Driver.fromJson(data);
  }
}