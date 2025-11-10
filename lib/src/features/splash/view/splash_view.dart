import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../styles/const/AppConstants.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _buttonController;
  bool _showButton = false;
  bool _showStats = false;
  bool _loadingDone = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Simula la carga
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _loadingDone = true;
        _showStats = true;
      });
      Future.delayed(const Duration(milliseconds: 700), () {
        setState(() => _showButton = true);
        _buttonController.forward();
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: Stack(
        children: [
          // Fondo con degradado
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.baseBackground, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animado
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (_, child) {
                      final offset =
                          5 * (1 - (_logoController.value - 0.5).abs() * 2);
                      return Transform.translate(
                        offset: Offset(0, -offset),
                        child: child,
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                        BorderRadius.circular(AppConstants.buttonRadius * 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.show_chart,
                        color: Colors.white,
                        size: AppConstants.textTittle + 28,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppConstants.defaultHeight),

                  // Título
                  const Text(
                    AppConstants.appName,
                    style: TextStyle(
                      fontSize: AppConstants.textTittle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: AppConstants.formHeight),

                  // Subtítulo
                  const Text(
                    "Gestiona tus finanzas de forma inteligente y sencilla",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppConstants.textLabel + 2,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: AppConstants.defaultHeight * 1.5),

                  // Barra de carga o estadísticas
                  if (!_loadingDone)
                    Column(
                      children: [
                        const Text(
                          "Cargando tu experiencia financiera...",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppConstants.textLabel,
                          ),
                        ),
                        const SizedBox(height: AppConstants.formHeight),
                        LinearProgressIndicator(
                          minHeight: 4,
                          borderRadius:
                          BorderRadius.circular(AppConstants.buttonRadius),
                          color: AppColors.primary,
                          backgroundColor:
                          AppColors.primary.withOpacity(0.2),
                        ),
                      ],
                    )
                  else
                    AnimatedOpacity(
                      opacity: _showStats ? 1 : 0,
                      duration: const Duration(milliseconds: 800),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: AppConstants.formHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            _StatItem(number: "+10K", label: "Usuarios"),
                            SizedBox(width: AppConstants.defaultMargin),
                            _StatItem(number: "99%", label: "Satisfacción"),
                            SizedBox(width: AppConstants.defaultMargin),
                            _StatItem(number: "#1", label: "Finanzas"),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: AppConstants.defaultHeight * 1.5),

                  // Botón Comenzar
                  if (_showButton)
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _buttonController,
                        curve: Curves.easeOutBack,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Navegar al login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultMargin * 2.5,
                            vertical: AppConstants.formHeight,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstants.buttonRadius * 4),
                          ),
                          elevation: 8,
                        ),
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text(
                          "Comenzar Ahora",
                          style: TextStyle(
                            fontSize: AppConstants.textInput,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: AppConstants.textInput,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.textLabel,
          ),
        ),
      ],
    );
  }
}
