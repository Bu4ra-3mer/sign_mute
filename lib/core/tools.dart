import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SizedBox vSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}

SizedBox hSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

TextTheme tstyle(context) => Theme.of(context).textTheme;

RegExp emailRegExp =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
