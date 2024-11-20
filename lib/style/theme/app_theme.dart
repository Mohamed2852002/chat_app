import 'package:chat_app/style/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final apptheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    scaffoldBackgroundColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
    ),
  );
}
