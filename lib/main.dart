import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sign_mute/view/auth/login_page.dart';
import 'package:sign_mute/view/auth/sign_up_page.dart';
import 'package:sign_mute/view/home/home_page.dart';

import 'view/onboarding/onboarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: redAccent,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: yellowAccent),
          ),
        ),
      ),
      builder: BotToastInit(),
      routes: {
        '/': (_) => OnboardingPage(),
        '/home': (_) => HomePage(),
        '/login': (_) => LoginPage(),
        '/signUp': (_) => SignUpPage(),
      },
    );
  }
}
