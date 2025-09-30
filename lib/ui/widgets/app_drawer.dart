import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? _driverName;

  @override
  void initState() {
    super.initState();
    _loadDriverName();
  }

  Future<void> _loadDriverName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _driverName = prefs.getString(
        'driverName',
      ); // ⚠️ make sure you save this at login
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                _driverName != null ? "$_driverName" : "Conductor",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text("📊 Reportes diarios"),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/reportes'),
                ),
                ListTile(
                  title: const Text("💵 Pagos"),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/pagos'),
                ),
                ListTile(
                  title: const Text("🏦 Balance"),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/balance'),
                ),
                ListTile(
                  title: const Text("🎯 Goal Bonus"),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/goal_bonus'),
                ),
                ListTile(
                  title: const Text("📅 Reporte Semanal"),
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    '/reporte_semanal',
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text("Cerrar sesión"),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
