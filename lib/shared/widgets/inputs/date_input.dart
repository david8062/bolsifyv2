import 'package:flutter/material.dart';
import '../../../../styles/colors/app_colors.dart';
import '../../../../styles/const/app_constants.dart';

class DateInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;

  const DateInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? now,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null) {
      widget.controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: AppConstants.textLabel,
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong,
          ),
        ),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: _pickDate,
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hint,
                prefixIcon: Icon(Icons.calendar_month, color: AppColors.iconColor),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
                  borderSide: BorderSide(
                    color: AppColors.textPrimary,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
