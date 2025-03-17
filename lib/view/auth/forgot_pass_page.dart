import 'package:flutter/material.dart';
import 'package:sign_mute/core/tools.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (v) {
                if (v!.isEmpty) {
                  return 'enter your email';
                }
                if (emailRegExp.hasMatch(v)) {
                  return 'enter valide ema9il';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          vSpace(2),
          ElevatedButton(
            onPressed: () {},
            child: Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }
}
