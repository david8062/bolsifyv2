import 'package:flutter/material.dart';
import 'package:bolsifyv2/styles/styles.dart';

class SelectInput<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> options;
  final String Function(T) labelBuilder;
  final Widget Function(T)? iconBuilder;
  final ValueChanged<T> onChanged;

  const SelectInput({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.labelBuilder,
    this.iconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.textSubTittle,
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            border: Border.all(color: AppColors.textThird.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: AppColors.cardBackground,
              style: TextStyle(
                color: AppColors.textStrong,
                fontSize: 15,
              ),
              items: options.map((option) {
                return DropdownMenuItem<T>(
                  value: option,
                  child: Row(
                    children: [
                      if (iconBuilder != null) ...[
                        iconBuilder!(option),
                        const SizedBox(width: 10),
                      ],
                      Text(labelBuilder(option)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) onChanged(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}
