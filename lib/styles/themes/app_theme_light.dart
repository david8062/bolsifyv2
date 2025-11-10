import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../const/AppConstants.dart';


class AppThemeLight {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.cardBackground,
      error: AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardBackground,
    shadowColor: AppColors.placeholder,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: AppConstants.textSubTittle,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppConstants.textInput,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppConstants.textLabel,
      ),
      titleLarge: TextStyle(
        color: AppColors.textStrong,
        fontSize: AppConstants.textTittle,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: AppColors.textThird,
        fontSize: AppConstants.textWarning,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding,
          horizontal: AppConstants.defaultMargin,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.buttonRadius),
          ),
        ),
        elevation: 2,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.formHeight,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        borderSide: const BorderSide(color: AppColors.placeholder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppConstants.textLabel,
      ),
    ),
  );
}
