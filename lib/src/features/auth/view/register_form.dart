import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../shared/widgets/widgets.dart';
import '../viewmodel/auth_viewmodel.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authVM = ref.read(authViewModelProvider.notifier);

    ref.listen<AsyncValue<void>>(authViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cuenta creada con éxito 🎉")),
        ),
        error: (err, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        ),
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputField(
            controller: _nameCtrl,
            hint: "Nombre completo",
            icon: Icons.person_outline,
            validator: (v) => v == null || v.isEmpty ? "Ingresa tu nombre" : null,
          ),
          const SizedBox(height: 16),
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
              if (v == null || v.isEmpty) return "Ingresa una contraseña";
              if (v.length < 6) return "Debe tener al menos 6 caracteres";
              return null;
            },
          ),
          const SizedBox(height: 16),
          InputField(
            controller: _confirmCtrl,
            hint: "Confirmar contraseña",
            icon: Icons.lock_reset_outlined,
            obscureText: true,
            validator: (v) {
              if (v != _passwordCtrl.text) return "Las contraseñas no coinciden";
              return null;
            },
          ),
          const SizedBox(height: 24),
          authState.isLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : AppNavButton(
            label: "Crear Cuenta",
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              authVM.register(
                name: _nameCtrl.text,
                email: _emailCtrl.text,
                password: _passwordCtrl.text,
              );
            },
          ),
        ],
      ),
    );
  }
}
