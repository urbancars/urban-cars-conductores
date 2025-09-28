import 'package:flutter/material.dart';
import 'ui/login/login_page.dart';
import 'ui/reportes/reportes_page.dart';
import 'ui/pagos/pagos_page.dart';
import 'ui/goal_bonus/goal_bonus_page.dart';
import 'ui/reportes_semanales/reporte_semanal_page.dart';
import 'ui/balance/balance_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Urban Cars Conductores',
  theme: ThemeData(primarySwatch: Colors.yellow),
  initialRoute: '/',
  routes: {
    '/': (context) => const LoginPage(),
    '/reportes': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return ReportesPage(driverId: args['driverId']);
    },
    '/pagos': (context) => const PagosPage(),
    '/balance': (context) => const BalancePage(),
    '/goal_bonus': (context) => const GoalBonusPage(),
    '/reportes_semanales': (context) => ReportesSemanalesPage(),
  },
);
  }
}