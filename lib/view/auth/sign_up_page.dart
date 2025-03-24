import 'package:flutter/material.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sign_mute/core/tools.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedGendar = 'Male';
  bool isAccepted = false;
  bool obsureText = true;
  final GlobalKey<FormState> loginForm = GlobalKey();

  RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: ' Enter Your Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: redAccent,
                  ),
                ),
              ),
              vSpace(3),
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
                  hintText: 'Enter Your Email',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: yellowAccent),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: redAccent,
                  ),
                ),
              ),
              vSpace(3),
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
                  hintText: 'Enter Your Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      obsureText = !obsureText;
                      setState(() {});
                    },
                    icon: Icon(
                      obsureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: redAccent,
                  ),
                ),
              ),
              vSpace(3),
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
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: redAccent,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      obsureText = !obsureText;
                      setState(() {});
                    },
                    icon: Icon(
                      obsureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              vSpace(3),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 'Male',
                      groupValue: selectedGendar,
                      onChanged: (mohamed) {
                        selectedGendar = mohamed!;
                        setState(() {});
                      },
                      title: Text('Male'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: 'Female',
                      groupValue: selectedGendar,
                      onChanged: (beshooo) {
                        selectedGendar = beshooo!;
                        setState(() {});
                      },
                      title: Text('Female'),
                    ),
                  )
                ],
              ),
              vSpace(3),
              CheckboxListTile(
                value: isAccepted,
                onChanged: (v) {
                  isAccepted = v!;
                  setState(() {});
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('I Accept terms of use & privacy policy'),
              ),
              vSpace(4),
              ElevatedButton(
                onPressed: () {
                  if (loginForm.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Sign Up',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
