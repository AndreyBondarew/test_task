import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light(BuildContext context) => ThemeData(
        fontFamily: 'Sora',
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.accentColor,
          onPrimary: AppColors.backgroundColor,
          secondary: AppColors.accentColor,
          onSecondary: AppColors.backgroundColor,
          error: AppColors.systemError,
          onError: AppColors.backgroundColor,
          surface: AppColors.backgroundColor,
          onSurface: AppColors.accentColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
}
