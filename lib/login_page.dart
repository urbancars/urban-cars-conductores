import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'reportes_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _docController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSavedDocument();
  }

  Future<void> _loadSavedDocument() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDoc = prefs.getString("documento");
    if (savedDoc != null && savedDoc.isNotEmpty) {
      setState(() {
        _docController.text = savedDoc;
      });
    }
  }

  Future<void> _login() async {
    final doc = _docController.text.trim();

    if (doc.isEmpty) {
      setState(() {
        _error = "Por favor, ingrese su documento";
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse("${AppConfig.apiUrl}?documento=$doc");
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        final conductor = data['conductor'];
        final conductorId = data['conductor_id'];

        if (conductor == null || conductorId == null) {
          setState(() {
            _error = "Documento no encontrado";
            _loading = false;
          });
          return;
        }

        // ✅ Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("documento", doc);
        await prefs.setString("conductor", conductor);
        await prefs.setString("conductor_id", conductorId.toString());

        if (!mounted) return;

        // Navigate to ReportesPage
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const ReportesPage()),
);
      } else {
        setState(() {
          _error = "Error del servidor: ${res.statusCode}";
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Error de conexión: $e";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ingrese su documento",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _docController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Documento",
                    errorText: _error,
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Ingresar"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
