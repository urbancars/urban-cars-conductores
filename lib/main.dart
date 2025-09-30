import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/login/login_event.dart';
import 'data/services/api_service.dart';
import 'data/repositories/login_repository.dart';
import 'data/repositories/pagos_repository.dart';
import 'data/repositories/balance_repository.dart';
import 'data/repositories/goal_bonus_repository.dart';
import 'data/repositories/reporte_semanal_repository.dart';
import 'data/repositories/reportes_repository.dart';
import 'config.dart';

import 'ui/login/login_page.dart';
import 'ui/reportes/reportes_page.dart';
import 'ui/pagos/pagos_page.dart';
import 'ui/balance/balance_page.dart';
import 'ui/goal_bonus/goal_bonus_page.dart';
import 'ui/reporte_semanal/reporte_semanal_page.dart';

void main() {
  final api = ApiService(baseUrl: AppConfig.apiUrl);

  // 🔹 Create repositories once (shared + cached)
  final loginRepository = LoginRepository(api);
  final pagosRepository = PagosRepository(api);
  final balanceRepository = BalanceRepository(api);
  final goalBonusRepository = GoalBonusRepository(api);
  final reporteSemanalRepository = ReporteSemanalRepository(api);
  final reportesRepository = ReportesRepository(api);

  runApp(
    MyApp(
      loginRepository: loginRepository,
      pagosRepository: pagosRepository,
      balanceRepository: balanceRepository,
      goalBonusRepository: goalBonusRepository,
      reporteSemanalRepository: reporteSemanalRepository,
      reportesRepository: reportesRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository;
  final PagosRepository pagosRepository;
  final BalanceRepository balanceRepository;
  final GoalBonusRepository goalBonusRepository;
  final ReporteSemanalRepository reporteSemanalRepository;
  final ReportesRepository reportesRepository;

  const MyApp({
    super.key,
    required this.loginRepository,
    required this.pagosRepository,
    required this.balanceRepository,
    required this.goalBonusRepository,
    required this.reporteSemanalRepository,
    required this.reportesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginRepository>.value(value: loginRepository),
        RepositoryProvider<PagosRepository>.value(value: pagosRepository),
        RepositoryProvider<BalanceRepository>.value(value: balanceRepository),
        RepositoryProvider<GoalBonusRepository>.value(
          value: goalBonusRepository,
        ),
        RepositoryProvider<ReporteSemanalRepository>.value(
          value: reporteSemanalRepository,
        ),
        RepositoryProvider<ReportesRepository>.value(value: reportesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(
              loginRepository: loginRepository,
              pagosRepository: pagosRepository,
              balanceRepository: balanceRepository,
              goalBonusRepository: goalBonusRepository,
              reporteSemanalRepository: reporteSemanalRepository,
              reportesRepository: reportesRepository,
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Urban Cars Conductores',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            '/home': (context) => const ReportesPage(),
            '/reportes': (context) => const ReportesPage(),
            '/pagos': (context) => const PagosPage(),
            '/balance': (context) => const BalancePage(),
            '/goal_bonus': (context) => const GoalBonusPage(),
            '/reporte_semanal': (context) => const ReporteSemanalPage(),
          },
        ),
      ),
    );
  }
}
