import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../styles/colors/app_colors.dart';

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

    // Simula la carga (como en tu JS)
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
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.show_chart,
                        color: Colors.white, size: 60),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Bolsify",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Gestiona tus finanzas de forma inteligente y sencilla",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                // Barra de carga o stats
                if (!_loadingDone)
                  Column(
                    children: [
                      const Text("Cargando tu experiencia financiera...",
                          style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(20),
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
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _StatItem(number: "+10K", label: "Usuarios"),
                          SizedBox(width: 30),
                          _StatItem(number: "99%", label: "Satisfacción"),
                          SizedBox(width: 30),
                          _StatItem(number: "#1", label: "Finanzas"),
                        ],
                      ),
                    ),
                  ),

                // Botón “Comenzar”
                const SizedBox(height: 40),
                if (_showButton)
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _buttonController,
                      curve: Curves.easeOutBack,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: navegar al login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 8,
                      ),
                      icon: const Icon(Icons.rocket_launch),
                      label: const Text(
                        "Comenzar Ahora",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
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
        Text(number,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: 18)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}
