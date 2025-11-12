import 'package:flutter/material.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../styles/const/app_constants.dart';

class AuthTab extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const AuthTab({
    super.key,
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.white : AppColors.background,
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          boxShadow: active
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active ? AppColors.primary : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
