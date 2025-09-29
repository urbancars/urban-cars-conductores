import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_state.dart';
import '../../data/repositories/login_repository.dart';
import '../../data/services/api_service.dart';
import '../../config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _documentoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        LoginRepository(ApiService(baseUrl: AppConfig.apiUrl)), // ✅ fixed
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              final driver = state.driver;

              // Save driver info into SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('driver_id', driver.id);
              await prefs.setString('driver_name', driver.name);
              await prefs.setString('driver_documento', driver.documento);

              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/reportes');
            }

            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _documentoController,
                    decoration: const InputDecoration(
                      labelText: "Documento",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final documento = _documentoController.text.trim();
                      if (documento.isNotEmpty) {
                        context.read<LoginBloc>().login(documento);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("⚠️ Ingresa tu documento")),
                        );
                      }
                    },
                    child: const Text("Ingresar"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
