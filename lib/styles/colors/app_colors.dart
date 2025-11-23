import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF1E3A8A);
  static const Color secondary = Color(0xFF60A5FA);

  // Backgrounds
  static const Color background = Color(0xFFF3F4F6);
  static const Color baseBackground = Color(0xFFDBEAFE);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color transparentBackground = Color(0x32FFFFFF);

  // Surfaces / Status
  static const Color surface = Color(0xFF10B981);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFB00020);

  // Text
  static const Color textStrong = Color(0xFF0C0101);
  static const Color textPrimary = Color(0xFF374151);
  static const Color textSecondary = Color(0xFF49454F);
  static const Color textThird = Color(0xFFBAC1D7);

  static const Color iconColor = Color(0xFF808080);

  // Misc
  static const Color placeholder = Color(0xFFBCC3CE);
  static const double borderRadius = 12.0;
  static const BoxShadow shadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 6,
    offset: Offset(0, 4),
  );
}

