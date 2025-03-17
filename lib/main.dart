import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sign_mute/config/theme.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sign_mute/view/auth/forgot_pass_page.dart';
import 'package:sign_mute/view/auth/login_page.dart';
import 'package:sign_mute/view/auth/sign_up_page.dart';
import 'package:sign_mute/view/home/home_page.dart';
import 'package:sign_mute/view/service/learn_page.dart';
import 'package:sign_mute/view/service/service_page.dart';
import 'package:sizer/sizer.dart';

import 'view/onboarding/onboarding_page.dart';
import 'view/service/trans_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceTyp) {
      return MaterialApp(
        initialRoute: '/',
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: BotToastInit(),
        routes: {
          '/': (_) => OnboardingPage(),
          '/home': (_) => HomePage(),
          '/login': (_) => LoginPage(),
          '/signUp': (_) => SignUpPage(),
          '/service': (_) => ServicePage(),
          '/trans': (_) => TransPage(),
          '/learn': (_) => LearnPage(),
          '/forgotpass': (_) => ForgotPassPage(),
        },
      );
    });
  }
}
