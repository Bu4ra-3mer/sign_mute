import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          vSpace(20),
          Image.asset(
            Assets.assetsLogo,
            width: 100,
            height: 100,
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: Text('App'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Learn'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Donat'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Service'),
            onTap: () {
              Navigator.pushNamed(context, '/service');
            },
          ),
        ],
      ),
    );
  }
}
