import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'utils.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({super.key});

  @override
  State<PagosPage> createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  List<dynamic> _items = [];
  bool _loading = true;
  String? _documento;

  @override
  void initState() {
    super.initState();
    _loadAndFetch();
  }

  Future<void> _loadAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    _documento = prefs.getString("documento");
    if (_documento == null) {
      setState(() => _loading = false);
      return;
    }
    await _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final uri = Uri.parse("${AppConfig.apiUrl}?documento=$_documento&type=pagos");
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
      appBar: AppBar(title: const Text("Pagos")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text("No hay pagos"))
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _items.length,
                    itemBuilder: (_, i) {
                      final row = _items[i];
                      return Card(
                        child: ListTile(
                          title: Text("Monto: ${formatMoney(row['monto'])}"),
                          subtitle: Text("Fecha: ${formatDate(row['fecha'])}"),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}