import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF9775FA);
  static const primaryColorDark = Color(0xFF9775FA);
  static const secondaryColor = Color(0xFF8F959E);

  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF5F6FA);
  static const lightOnPrimary = Color(0xFFFEFEFE);

  static const darkBackground = Color(0xFF1B262C);
  static const darkSurface = Color(0xFF222E34);
  static const darkOnPrimary = Color(0xFFF5F8FB);
}

class AppTextStyles {
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
    color: AppColors.secondaryColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500, // Medium
    fontSize: 16,
    color: Color(0xff1D1E20),
  );

  static const TextStyle bodySemiBold = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 16,
    color: Color(0xff1D1E20),
  );
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.darkSurface),
    titleTextStyle: AppTextStyles.bodySemiBold.copyWith(
      color: AppColors.primaryColor,
      fontSize: 20,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: AppTextStyles.bodyRegular,
    bodyMedium: AppTextStyles.bodyMedium,
    bodyLarge: AppTextStyles.bodySemiBold,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    onPrimary: AppColors.lightOnPrimary,
    secondary: AppColors.secondaryColor,
    surface: AppColors.lightSurface,
    onSurface: Colors.black,
  ).copyWith(surface: AppColors.lightBackground),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColorDark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.darkOnPrimary),
    titleTextStyle: AppTextStyles.bodySemiBold.copyWith(
      color: AppColors.darkOnPrimary,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(
    bodySmall: AppTextStyles.bodyRegular.copyWith(color: AppColors.secondaryColor),
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Color(0xffF5F8FB)),
    bodyLarge: AppTextStyles.bodySemiBold.copyWith(color: Color(0xffF5F8FB)),
  ),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColorDark,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.secondaryColor,
    surface: AppColors.darkSurface,
    onSurface: Colors.white,
  ).copyWith(surface: AppColors.darkBackground),
);
