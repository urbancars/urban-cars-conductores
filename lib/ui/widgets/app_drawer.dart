import 'package:flutter/material.dart';
import '../pagos/pagos_page.dart';
import '../balance/balance_page.dart';
import '../goal_bonus/goal_bonus_page.dart';
import '../reportes/reportes_page.dart';
import '../reporte_semanal/reporte_semanal_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Menú", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text("📊 Reportes"),
            onTap: () => Navigator.pushNamed(context, '/reportes'),
          ),
          ListTile(
            title: const Text("💵 Pagos"),
            onTap: () => Navigator.pushNamed(context, '/pagos'),
          ),
          ListTile(
            title: const Text("🏦 Balance"),
            onTap: () => Navigator.pushNamed(context, '/balance'),
          ),
          ListTile(
            title: const Text("🎯 Goal Bonus"),
            onTap: () => Navigator.pushNamed(context, '/goal_bonus'),
          ),
          ListTile(
            title: const Text("📅 Reporte Semanal"),
            onTap: () => Navigator.pushNamed(context, '/reportes_semanales'),
          ),
        ],
      ),
    );
  }
}