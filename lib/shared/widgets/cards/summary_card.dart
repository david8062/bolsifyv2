import 'package:flutter/material.dart';
import 'package:bolsifyv2/styles/styles.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String amount;
  final String percentage;
  final bool positive;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
    required this.percentage,
    required this.positive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: AppColors.cardBackground,
        elevation: 4,
        shadowColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius * 2),
        ),
        child: Container(
          height: 140, //
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding * 1.5,
            vertical: AppConstants.defaultPadding,
          ),
          child: Row(
            children: [
              // Ícono con fondo circular más grande
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 20),

              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: AppConstants.textSubTittle,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: AppConstants.textTittle,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${positive ? '+' : '-'}$percentage vs mes anterior',
                      style: TextStyle(
                        fontSize: AppConstants.textLabel,
                        color: positive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
