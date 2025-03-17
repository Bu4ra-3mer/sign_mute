import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/tools.dart';
import 'package:sizer/sizer.dart';

class TransPage extends StatefulWidget {
  const TransPage({super.key});

  @override
  State<TransPage> createState() => _TransPageState();
}

class _TransPageState extends State<TransPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trans Sign Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.assetsUploadVidoe,
              width: 30.w,
            ),
            vSpace(5),
            ElevatedButton(
              onPressed: () {},
              child: Text('Pick a Video'),
            ),
          ],
        ),
      ),
    );
  }
}
