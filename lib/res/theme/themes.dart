import 'package:courier_app/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(
      color: AppColors.gray2,
      width: 1,
    ),
  );
  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(
      color: AppColors.gray1,
      width: 2,
    ),
  );
  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(
      color: AppColors.red,
      width: 2,
    ),
  );

  static ThemeData mainTheme = ThemeData(
    fontFamily: 'Manrope',
    textTheme: TextTheme(
      displayLarge: _AppTypography.headline1,
      displayMedium: _AppTypography.headline2,
      displaySmall: _AppTypography.headline3,
      headlineMedium: _AppTypography.headline4,
      headlineSmall: _AppTypography.headline5,
      titleLarge: _AppTypography.p4,
      bodyLarge: _AppTypography.bodyLarge,
      bodyMedium: _AppTypography.bodyMedium,
      bodySmall: _AppTypography.bodySmall,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: _AppTypography.headline1.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.gray1,
      ),
      border: _border,
      enabledBorder: _border,
      focusedBorder: _focusedBorder,
      errorBorder: _errorBorder,
    ),
  );
}

class _AppTypography {
  static const _letterSpacing = 0.97;
  static const _fontFam = 'Manrope';
  static TextStyle headline1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle headline3 = TextStyle(
    fontSize: 16.sp,
    letterSpacing: _letterSpacing,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle headline4 = TextStyle(
    fontSize: 14.sp,
    letterSpacing: _letterSpacing,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle headline5 = TextStyle(
    fontSize: 12.sp,
    letterSpacing: _letterSpacing,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    letterSpacing: _letterSpacing,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle p4 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    letterSpacing: _letterSpacing,
    fontFamily: _fontFam,
    color: AppColors.black,
  );
}
