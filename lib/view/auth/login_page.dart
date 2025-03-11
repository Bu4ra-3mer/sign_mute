import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sign_mute/core/tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsureText = true;
  final GlobalKey<FormState> loginForm = GlobalKey();

  RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  }
                  if (!emailRegExp.hasMatch(value)) {
                    return 'please enter valide email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Your email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              vSpace(40),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your password';
                  }
                  if (value.length < 8) {
                    return 'please enter latest char 8';
                  }
                  return null;
                },
                obscureText: obsureText,
                decoration: InputDecoration(
                  hintText: 'Your password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      obsureText = !obsureText;
                      setState(() {});
                    },
                    icon: Icon(
                        !obsureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              vSpace(20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              vSpace(50),
              ElevatedButton(
                onPressed: () {
                  if (loginForm.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                child: Text('SignUp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
