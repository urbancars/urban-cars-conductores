import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'utils.dart';
import 'pagos_page.dart';
import 'balance_page.dart';
import 'goal_bonus_page.dart';
import 'reporte_semanal_page.dart';
import 'login_page.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  List<dynamic> _items = [];
  bool _loading = true;
  String? _documento;
  String? _conductor;
  String? _conductorId;

  DateTime? _lastRefresh;

  @override
  void initState() {
    super.initState();
    _loadAndFetch();
  }

  Future<void> _loadAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    _documento = prefs.getString("documento");
    _conductorId = prefs.getString("conductor_id");
    _conductor = prefs.getString("conductor");
    if (_documento == null) {
      setState(() => _loading = false);
      return;
    }
    await _fetchData();
  }

  Future<void> _fetchData() async {
    // cooldown: 60s
    if (_lastRefresh != null) {
      final diff = DateTime.now().difference(_lastRefresh!);
      if (diff.inSeconds < 60) return;
    }

    setState(() => _loading = true);
    try {
      final uri = Uri.parse(
          "${AppConfig.apiUrl}?documento=$_documento&type=reportes&days=14");
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        setState(() {
          _items = List<dynamic>.from(jsonData['data'] ?? []);
          _conductor = jsonData['conductor'];
          _conductorId = jsonData['conductor_id']?.toString();
          _loading = false;
          _lastRefresh = DateTime.now();
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_conductor ?? "Reportes"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFFFD500)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 32),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _conductor ?? "Conductor",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_documento != null)
                    Text("Documento: $_documento"),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text("Pagos"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PagosPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Balance"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BalancePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text("Goal Bonus"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GoalBonusPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_week),
              title: const Text("Reportes Semanales"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ReporteSemanalPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar sesión"),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text("No hay reportes"))
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _items.length,
                    itemBuilder: (_, i) {
                      final row = _items[i];
                      final formattedDate = formatDate(row['fecha']);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header: date + plate
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    row['placa']?.toString() ?? "",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Viajes row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.local_taxi,
                                          color: Colors.yellow),
                                      SizedBox(width: 6),
                                      Text(
                                        "Viajes 🚖",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    row['viajes']?.toString() ?? "0",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Money rows with emojis
                              buildMoneyRow("Efectivo 💵", row['efectivo']),
                              buildMoneyRow("Ganancia No Efectivo 💳",
                                  row['ganancia no efectivo']),
                              buildMoneyRow("Gasto GNV ⛽", row['gasto GNV']),
                              buildMoneyRow(
                                  "Gasto Gasolina ⛽", row['gasto gasolina']),
                              buildMoneyRow("Ganancia Conductor 👤",
                                  row['ganancia conductor']),
                              buildMoneyRow("Total a Depositar 🏦",
                                  row['total a depositar'],
                                  bold: true),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget buildMoneyRow(String label, dynamic value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            formatMoney(value),
            style:
                TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}