// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:eqraa/core/app_export.dart';

import 'color.dart';

ThemeData get theme => ThemeData();
ThemeData themeEnglish = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.primaryColor,
    foregroundColor: AppColor.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColor.white,
    elevation: 5,
    selectedItemColor: AppColor.primaryColor,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColor.white, shape: CircularNotchedRectangle()),
  scaffoldBackgroundColor: AppColor.white,
  buttonTheme: ButtonThemeData(
    buttonColor: AppColor.primaryColor,
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
  primaryColor: AppColor.primaryColor,
  dialogBackgroundColor: AppColor.backGroundColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 10,
    backgroundColor: AppColor.thirdColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),
  fontFamily: "Inter",
  textTheme: TextTheme(
    labelLarge: const TextStyle(color: AppColor.white),
    bodyLarge: TextStyle(
      color: AppColor.gray,
      fontSize: 16.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: AppColor.primaryColor,
      fontSize: 24.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: AppColor.primaryColor,
      fontSize: 20.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: AppColor.secondColor,
      fontSize: 18.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch(primarySwatch: AppColor.primarymaterialcolor)
          .copyWith(background: AppColor.backGroundColor),
);

ThemeData themeArabic = ThemeData(
  appBarTheme: const AppBarTheme(
    color: AppColor.primaryColor,
    foregroundColor: AppColor.white,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme:
          InputDecorationTheme(focusColor: AppColor.primaryColor)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColor.white,
    elevation: 5,
    selectedItemColor: AppColor.primaryColor,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColor.white,
      elevation: 5,
      shadowColor: AppColor.primaryColor,
      shape: CircularNotchedRectangle()),
  scaffoldBackgroundColor: AppColor.backGroundColor,
  buttonTheme: ButtonThemeData(
    buttonColor: AppColor.primaryColor,
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
  primaryColor: AppColor.primaryColor,
  dialogBackgroundColor: AppColor.backGroundColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 10,
    backgroundColor: AppColor.thirdColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),
  fontFamily: "Inter",
  textTheme: TextTheme(
    labelLarge: const TextStyle(color: AppColor.white),
    bodyLarge: TextStyle(
      color: AppColor.gray,
      fontSize: 16.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: AppColor.primaryColor,
      fontSize: 24.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: AppColor.primaryColor,
      fontSize: 20.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: AppColor.secondColor,
      fontSize: 18.fSize,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch(primarySwatch: AppColor.primarymaterialcolor)
          .copyWith(background: AppColor.backGroundColor),
);

class MyTextStyle {
  static TextStyle title = theme.textTheme.titleLarge!.copyWith(
    color: AppColor.primaryColor,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleSmall = theme.textTheme.titleLarge!.copyWith(
    color: AppColor.primaryColor,
    fontSize: 22,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleLarge = theme.textTheme.titleLarge!.copyWith(
    color: AppColor.primaryColor,
    fontSize: 26,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle body = theme.textTheme.bodyLarge!.copyWith(
    color: AppColor.gray,
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyLarge = theme.textTheme.headlineSmall!.copyWith(
    color: AppColor.thirdColor,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodySmall = theme.textTheme.headlineMedium!.copyWith(
    color: AppColor.gray,
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
}
