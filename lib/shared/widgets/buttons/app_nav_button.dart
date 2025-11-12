import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../styles/colors/app_colors.dart';
import '../../../styles/const/app_constants.dart';

class AppNavButton extends StatelessWidget {
  final String label;
  final String? route;
  final IconData icon;
  final Color? color;
  final AnimationController? animationController;
  final VoidCallback? onPressed;

  const AppNavButton({
    super.key,
    required this.label,
    this.route,
    this.icon = Icons.arrow_forward,
    this.color,
    this.animationController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else if (route != null) {
          context.go(route!);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultMargin * 2.5,
          vertical: AppConstants.formHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius * 4),
        ),
        elevation: 8,
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: AppConstants.textInput,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (animationController == null) return button;

    return ScaleTransition(
      scale: CurvedAnimation(parent: animationController!, curve: Curves.easeOutBack),
      child: button,
    );
  }
}
