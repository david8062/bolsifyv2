import 'package:flutter/material.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../styles/const/app_constants.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'login_form.dart';
import 'register_form.dart';
import '../widgets/auth_tab.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late AuthViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AuthViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultMargin),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(AppConstants.defaultMargin * 1.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.show_chart, size: 48, color: AppColors.primary),
                const SizedBox(height: 10),
                const Text(
                  'Bolsify',
                  style: TextStyle(
                    fontSize: AppConstants.textSubTittle,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Gestiona tus finanzas de forma inteligente',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AuthTab(
                        text: "Iniciar Sesión",
                        active: !_viewModel.isRegistering,
                        onTap: () => setState(_viewModel.showLogin),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AuthTab(
                        text: "Registrarse",
                        active: _viewModel.isRegistering,
                        onTap: () => setState(_viewModel.showRegister),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _viewModel.isRegistering
                      ? const RegisterForm()
                      : const LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
