import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../viewmodel/auth_viewmodel.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final auth = ref.read(authViewModelProvider.notifier);

    try {
      await auth.login(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );

      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inicio de sesión exitoso ✅")),
        );

        // 👇 Redirigir al home
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey("login_form"),
        children: [
          InputField(
            controller: _emailCtrl,
            hint: "Correo electrónico",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return "Ingresa tu correo";
              if (!v.contains('@')) return "Correo inválido";
              return null;
            },
          ),
          const SizedBox(height: 16),
          InputField(
            controller: _passwordCtrl,
            hint: "Contraseña",
            icon: Icons.lock_outline,
            obscureText: true,
            validator: (v) {
              if (v == null || v.isEmpty) return "Ingresa tu contraseña";
              if (v.length < 6) return "Debe tener al menos 6 caracteres";
              return null;
            },
          ),
          const SizedBox(height: 24),
          _loading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : AppNavButton(
            label: "Iniciar Sesión",
            icon: Icons.login,
            onPressed: _onLogin,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text(
              "¿Olvidaste tu contraseña?",
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
