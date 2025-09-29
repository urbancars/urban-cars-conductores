import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/balance/balance_bloc.dart';
import 'bloc/pagos/pagos_bloc.dart';
import 'bloc/goal_bonus/goal_bonus_bloc.dart';
import 'bloc/reportes/reportes_bloc.dart';
import 'bloc/reporte_semanal/reporte_semanal_bloc.dart';

import 'data/services/api_service.dart';
import 'data/repositories/login_repository.dart';
import 'data/repositories/balance_repository.dart';
import 'data/repositories/pagos_repository.dart';
import 'data/repositories/goal_bonus_repository.dart';
import 'data/repositories/reportes_repository.dart';
import 'data/repositories/reporte_semanal_repository.dart';

import 'ui/login/login_page.dart';
import 'ui/balance/balance_page.dart';
import 'ui/pagos/pagos_page.dart';
import 'ui/goal_bonus/goal_bonus_page.dart';
import 'ui/reportes/reportes_page.dart';
import 'ui/reporte_semanal/reporte_semanal_page.dart';

import 'config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiService(baseUrl: AppConfig.apiUrl);

  final loginRepository = LoginRepository(api);
  final balanceRepository = BalanceRepository(api);
  final pagosRepository = PagosRepository(api);
  final goalBonusRepository = GoalBonusRepository(api);
  final reportesRepository = ReportesRepository(api);
  final reporteSemanalRepository = ReporteSemanalRepository(api);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(loginRepository)),
        BlocProvider<BalanceBloc>(
          create: (_) => BalanceBloc(balanceRepository),
        ),
        BlocProvider<PagosBloc>(create: (_) => PagosBloc(pagosRepository)),
        BlocProvider<GoalBonusBloc>(
          create: (_) => GoalBonusBloc(goalBonusRepository),
        ),
        BlocProvider<ReportesBloc>(
          create: (_) => ReportesBloc(reportesRepository),
        ),
        BlocProvider<ReporteSemanalBloc>(
          create: (_) => ReporteSemanalBloc(reporteSemanalRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('driverId');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Cars Conductores',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data == true) {
            return const ReportesPage(); // 🚀 Start after login
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const ReportesPage(),
        '/login': (context) => const LoginPage(),
        '/reportes': (context) => const ReportesPage(),
        '/pagos': (context) => const PagosPage(),
        '/balance': (context) => const BalancePage(),
        '/goal_bonus': (context) => const GoalBonusPage(),
        '/reportes_semanales': (context) => const ReporteSemanalPage(),
      },
    );
  }
}
