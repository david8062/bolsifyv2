import 'package:flutter/material.dart';
import 'package:bolsifyv2/styles/styles.dart';

class SettingsCardContainer extends StatelessWidget {
  final String title;
  final Widget? actionButton;
  final Widget child;

  const SettingsCardContainer({
    super.key,
    required this.title,
    required this.child,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con título y botón opcional
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textStrong,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (actionButton != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: actionButton!,
                ),
            ],
          ),

          const SizedBox(height: 20),

          child,
        ],
      ),
    );
  }
}
