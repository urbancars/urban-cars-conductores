import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../data/models/driver.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _documentoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            final Driver driver = state.driver;

            // Save driver data into SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('driverId', driver.id);
            await prefs.setString('driverName', driver.name);
            await prefs.setString('driverDocumento', driver.documento);

            // Navigate to home
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
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
                      context.read<LoginBloc>().add(
                        LoginSubmitted(documento: documento),
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
    );
  }
}
