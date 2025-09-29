import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'data/services/api_service.dart';
import 'ui/login/login_page.dart';
import 'ui/reportes/reportes_page.dart';
import 'ui/pagos/pagos_page.dart';
import 'ui/balance/balance_page.dart';
import 'ui/goal_bonus/goal_bonus_page.dart';
import 'ui/reporte_semanal/reporte_semanal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<int?> _loadDriverId() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('driver_id');
    if (stored == null || stored.isEmpty) return null;
    return int.tryParse(stored); // ✅ convert String → int
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Cars Conductores',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<int?>(
        future: _loadDriverId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final driverId = snapshot.data;
          if (driverId == null) {
            return const LoginPage();
          }

          // ✅ Default page after login
          return ReportesPage(driverId: driverId);
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/reportes': (context) => FutureBuilder<int?>(
              future: _loadDriverId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoginPage();
                return ReportesPage(driverId: snapshot.data!);
              },
            ),
        '/pagos': (context) => FutureBuilder<int?>(
              future: _loadDriverId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoginPage();
                return PagosPage(driverId: snapshot.data!);
              },
            ),
        '/balance': (context) => FutureBuilder<int?>(
              future: _loadDriverId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoginPage();
                return BalancePage(driverId: snapshot.data!);
              },
            ),
        '/goal_bonus': (context) => FutureBuilder<int?>(
              future: _loadDriverId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoginPage();
                return GoalBonusPage(driverId: snapshot.data!);
              },
            ),
        '/reportes_semanales': (context) => FutureBuilder<int?>(
              future: _loadDriverId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoginPage();
                return ReporteSemanalPage(driverId: snapshot.data!);
              },
            ),
      },
    );
  }
}