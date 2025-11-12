import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../styles/const/app_constants.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel(vsync: this);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        splashViewModelProvider.overrideWith((ref) => _viewModel),
      ],
      child: Consumer(
        builder: (context, ref, _) {
          final vm = ref.watch(splashViewModelProvider);

          return Scaffold(
            backgroundColor: AppColors.baseBackground,
            body: Stack(
              children: [
                _buildBackground(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAnimatedLogo(vm.logoController),
                        const SizedBox(height: AppConstants.defaultHeight),
                        _buildTitle(),
                        const SizedBox(height: AppConstants.formHeight),
                        _buildSubtitle(),
                        const SizedBox(height: AppConstants.defaultHeight * 1.5),
                        if (vm.showButton)
                          _buildStartButton(vm.buttonController),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.baseBackground, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo(AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        final offset = 5 * (1 - (controller.value - 0.5).abs() * 2);
        return Transform.translate(offset: Offset(0, -offset), child: child);
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
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius * 2.5),
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
    );
  }

  Widget _buildTitle() => const Text(
    AppConstants.appName,
    style: TextStyle(
      fontSize: AppConstants.textTittle,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    ),
  );

  Widget _buildSubtitle() => const Text(
    "Gestiona tus finanzas de forma inteligente y sencilla",
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: AppConstants.textLabel + 2,
      color: AppColors.textSecondary
    ),
  );

  _buildStartButton(AnimationController controller) {
    return AppNavButton(
      label: "Comenzar Ahora",
      icon: Icons.rocket_launch,
      route: '/auth', // o '/home' si luego cambias
      animationController: controller,
    );
  }

}
