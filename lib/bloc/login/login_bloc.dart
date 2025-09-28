import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoadSavedDocument>(_onLoadSavedDocument);
    on<SubmitLogin>(_onSubmitLogin);
  }

  /// Load any saved login from SharedPreferences
  Future<void> _onLoadSavedDocument(
      LoadSavedDocument event, Emitter<LoginState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final doc = prefs.getString("documento");
    final driverName = prefs.getString("driverName");
    final driverId = prefs.getString("driverId");

    if (doc != null && doc.isNotEmpty && driverId != null) {
      emit(LoginSuccess(doc, driverName: driverName, driverId: driverId));
    }
  }

  /// Handle login attempt
  Future<void> _onSubmitLogin(
      SubmitLogin event, Emitter<LoginState> emit) async {
    if (event.documento.isEmpty) {
      emit(LoginFailure("Ingrese su documento"));
      return;
    }

    emit(LoginLoading());

    try {
      final driverData = await repository.validateDriver(event.documento);

      if (driverData == null) {
        emit(LoginFailure("Documento no encontrado"));
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("documento", driverData['documento']);
      await prefs.setString("driverName", driverData['conductor']);
      await prefs.setString("driverId", driverData['conductor_id'].toString());

      emit(LoginSuccess(
        driverData['documento'],
        driverName: driverData['conductor'],
        driverId: driverData['conductor_id'].toString(),
      ));
    } catch (e) {
      emit(LoginFailure("Error: $e"));
    }
  }
}