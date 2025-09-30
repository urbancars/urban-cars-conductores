import 'package:flutter/material.dart';
import '../../data/services/driver_session.dart';

class DriverGuard extends StatelessWidget {
  final Widget Function(BuildContext context, String driverId) builder;

  const DriverGuard({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: DriverSession.getDriverId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final driverId = snapshot.data;
        if (driverId == null) {
          // 🚨 redirect to login if missing
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return builder(context, driverId);
      },
    );
  }
}
