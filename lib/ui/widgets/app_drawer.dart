import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reportes/reportes_page.dart';
import '../pagos/pagos_page.dart';
import '../balance/balance_page.dart';
import '../goal_bonus/goal_bonus_page.dart';
import '../reporte_semanal/reporte_semanal_page.dart';
import '../login/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<Map<String, String?>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'driverId': prefs.getString('driverId'),
      'conductor': prefs.getString('conductor'),
      'documento': prefs.getString('documento'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!;
          final driverIdStr = userData['driverId'];
          final conductor = userData['conductor'] ?? 'Conductor';

          int? driverId = driverIdStr != null ? int.tryParse(driverIdStr) : null;

          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(conductor),
                accountEmail: Text(userData['documento'] ?? ''),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person, size: 32),
                ),
              ),
              ListTile(
                leading: const Text("📊", style: TextStyle(fontSize: 20)),
                title: const Text("Reportes"),
                onTap: () {
                  if (driverId != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportesPage(driverId: driverId),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Text("💵", style: TextStyle(fontSize: 20)),
                title: const Text("Pagos"),
                onTap: () {
                  if (driverId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PagosPage(driverId: driverId),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Text("💰", style: TextStyle(fontSize: 20)),
                title: const Text("Balance"),
                onTap: () {
                  if (driverId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BalancePage(driverId: driverId),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Text("🎯", style: TextStyle(fontSize: 20)),
                title: const Text("Goal Bonus"),
                onTap: () {
                  if (driverId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GoalBonusPage(driverId: driverId),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Text("📆", style: TextStyle(fontSize: 20)),
                title: const Text("Reportes Semanales"),
                onTap: () {
                  if (driverId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReporteSemanalPage(driverId: driverId),
                      ),
                    );
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Cerrar sesión"),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}