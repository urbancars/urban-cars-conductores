import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../data/repositories/login_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _docController = TextEditingController();

  @override
  void dispose() {
    _docController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(LoginRepository())..add(LoadSavedDocument()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Iniciar sesión")),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navigate to Reportes with STRING driverId
              Navigator.pushReplacementNamed(
                context,
                '/reportes',
                arguments: {'driverId': state.driverId}, // <-- the right var
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            final String? error =
                state is LoginFailure ? state.message : null;

            // Pre-fill when we know the documento (without side-effects)
            if (state is LoginSuccess && _docController.text.isEmpty) {
              _docController.text = state.documento;
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _docController,
                    decoration: const InputDecoration(
                      labelText: "Documento",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  if (error != null)
                    Text(error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final doc = _docController.text.trim();
                            context.read<LoginBloc>().add(SubmitLogin(doc));
                          },
                          child: const Text("Entrar"),
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