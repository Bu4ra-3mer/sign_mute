import 'package:flutter/material.dart';
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
      routes: {
        '/': (_) => OnboardingPage(),
        '/home': (_) => HomePage(),
        '/login': (_) => LoginPage(),
        '/signUp': (_) => SignUpPage(),
        
      },
    );
  }
}
