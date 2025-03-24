import 'package:flutter/material.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sizer/sizer.dart';

final ThemeData globalTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(80.w, 60),
      maximumSize: Size(80.w, 60),
      backgroundColor: redAccent,
      foregroundColor: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: redAccent,
      ),
    ),
  ),
);
final ThemeData lightTheme = globalTheme.copyWith();
final ThemeData darkTheme = globalTheme.copyWith(brightness: Brightness.dark);
