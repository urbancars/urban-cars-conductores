import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/login_repository.dart';
import '../../data/repositories/pagos_repository.dart';
import '../../data/repositories/balance_repository.dart';
import '../../data/repositories/goal_bonus_repository.dart';
import '../../data/repositories/reporte_semanal_repository.dart';
import '../../data/repositories/reportes_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final PagosRepository pagosRepository;
  final BalanceRepository balanceRepository;
  final GoalBonusRepository goalBonusRepository;
  final ReporteSemanalRepository reporteSemanalRepository;
  final ReportesRepository reportesRepository;

  LoginBloc({
    required this.loginRepository,
    required this.pagosRepository,
    required this.balanceRepository,
    required this.goalBonusRepository,
    required this.reporteSemanalRepository,
    required this.reportesRepository,
  }) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<Logout>(_onLogout); // ✅ added
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final driver = await loginRepository.login(event.documento);
      emit(LoginSuccess(driver));
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      emit(LoginFailure(msg));
    }
  }

  void _onLogout(Logout event, Emitter<LoginState> emit) {
    // ✅ Clear all cached data when logging out
    pagosRepository.clearCache();
    balanceRepository.clearCache();
    goalBonusRepository.clearCache();
    reporteSemanalRepository.clearCache();
    reportesRepository.clearCache();

    emit(LoginInitial()); // reset state back to initial
  }
}
