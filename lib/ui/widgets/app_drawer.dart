import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.yellow),
            child: Text(
              'Menú',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Reportes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/reportes',
                  arguments: ModalRoute.of(context)!.settings.arguments);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pagos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pagos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Balance'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/balance');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bolt),
            title: const Text('Goal Bonus'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/goal_bonus');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_view_week),
            title: const Text('Reportes Semanales'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/reportes_semanales');
            },
          ),
        ],
      ),
    );
  }
}