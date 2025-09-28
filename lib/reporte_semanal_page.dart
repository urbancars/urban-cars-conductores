import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'utils.dart';
import 'reporte_semanal_detail_page.dart';

class ReporteSemanalPage extends StatefulWidget {
  const ReporteSemanalPage({super.key});

  @override
  State<ReporteSemanalPage> createState() => _ReporteSemanalPageState();
}

class _ReporteSemanalPageState extends State<ReporteSemanalPage> {
  List<dynamic> _items = [];
  bool _loading = true;
  String? _conductorId;

  @override
  void initState() {
    super.initState();
    _loadAndFetch();
  }

  Future<void> _loadAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    _conductorId = prefs.getString("conductor_id");
    if (_conductorId == null) {
      setState(() => _loading = false);
      return;
    }
    await _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final uri = Uri.parse("${AppConfig.apiUrl}?type=reporte_semanal&conductor_id=$_conductorId");
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        setState(() {
          _items = List<dynamic>.from(jsonData['data'] ?? []);
          _loading = false;
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reportes Semanales")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text("No hay reportes semanales"))
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _items.length,
                    itemBuilder: (_, i) {
                      final row = _items[i];
                      return Card(
                        child: ListTile(
                          title: Text("Semana: ${row['semana_id']}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReporteSemanalDetailPage(data: row),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}