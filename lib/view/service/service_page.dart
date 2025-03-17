import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/colors.dart';
import 'package:sign_mute/core/tools.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vSpace(10),
          Text(
            'Our Service',
            style: tstyle(context)
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold, color: redAccent),
          ),
          vSpace(10),
          ListTile(
            onTap: () {},
            leading: Image.asset(Assets.assetsConvertVideo),
            title: Text('Text Into Video'),
            subtitle: Text('convert any text into video sign language'),
          ),
          vSpace(2),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/learn');
            },
            leading: Image.asset(Assets.assetsLearnLang),
            title: Text('Learn Sign Language'),
            subtitle: Text('Learn how to talk sign language'),
          ),
          vSpace(2),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/trans');
            },
            leading: Image.asset(Assets.assetsLangTrans),
            title: Text('Translate Sign Language'),
            subtitle: Text('Translate sign language by video or image'),
          ),
        ],
      ),
    );
  }
}
