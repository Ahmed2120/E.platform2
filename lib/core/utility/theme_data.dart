import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),

      primaryColor: AppColors.primaryColor,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: AppColors.primaryColor,
        brightness: Brightness.light,
      ),

      cardColor: const Color(0xFFF2FDFD),
      canvasColor:Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: const ColorScheme.light()),

      fontFamily: 'Cairo',

      textTheme: TextTheme(
        displayLarge: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        bodyLarge: const TextStyle(fontSize: 18.0, color: AppColors.primaryColor),
        bodyMedium: const TextStyle(fontSize: 16.0, color: AppColors.primaryColor),
        titleMedium: TextStyle(fontSize: 17.0, color: AppColors.titleMediumColor),
        headlineLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.titleMediumColor),
        bodySmall: TextStyle(fontSize: 15.0, color: AppColors.titleMediumColor),
        labelSmall: const TextStyle(fontSize: 13),

      ),
    );
  }
}
