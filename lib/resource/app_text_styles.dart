import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle regular14({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 19.6 / 14.0,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle regular16({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 19.2 / 16.0,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle semiBold16({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 19.2 / 16.0,
        color: color ?? AppColors.textPrimary,
      );
}
