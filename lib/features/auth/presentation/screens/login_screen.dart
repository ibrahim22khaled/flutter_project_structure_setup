import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure_setup/shared/utils/app_toasts.dart';

import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// LEARNING NOTES:
/// Responsible for: UI and state only.
/// NOT allowed to: import from the data layer directly.
///
/// PURPOSE: The screen where users enter their credentials.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      // We use BlocProvider.value here because getIt<AuthCubit>() is already instantiated
      // as a global singleton, and we want to listen to that specific instance so GoRouter
      // picks up the state changes correctly.
      body: BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // Show a snackbar only when an error occurs
            if (state is AuthError) {
              AppToasts.error(context, message: state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 32),
                  LoadingButton(
                    text: 'Login',
                    isLoading: isLoading,
                    onPressed: () {
                      final email = _emailController.text.trim();
                      final pass = _passwordController.text.trim();
                      if (email.isNotEmpty && pass.isNotEmpty) {
                        context.read<AuthCubit>().login(email, pass);
                      }
                    },
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
