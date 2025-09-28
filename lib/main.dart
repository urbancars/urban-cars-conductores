import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reportes_page.dart';
import 'login_page.dart';

void main() {
  runApp(const UrbanCarsApp());
}

class UrbanCarsApp extends StatelessWidget {
  const UrbanCarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Cars Conductores',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartupPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  bool _loading = true;
  String? _documento;
  String? _conductor;
  String? _conductorId;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final doc = prefs.getString("documento");
    final name = prefs.getString("conductor");
    final id = prefs.getString("conductor_id");

    // ✅ Require all 3 values, otherwise force login
    if (doc != null && doc.isNotEmpty &&
        name != null && name.isNotEmpty &&
        id != null && id.isNotEmpty) {
      setState(() {
        _documento = doc;
        _conductor = name;
        _conductorId = id;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ✅ If all values exist → ReportesPage, else LoginPage
    if (_documento != null && _conductor != null && _conductorId != null) {
      return ReportesPage(

      );
    } else {
      return const LoginPage();
    }
  }
}
