import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(const AssetImage(Assets.assetsOnboard1), context);
    precacheImage(const AssetImage(Assets.assetsOnboard2), context);
    precacheImage(const AssetImage(Assets.assetsOnboard3), context);
  }

  final List<String> images = [
    Assets.assetsOnboard1,
    Assets.assetsOnboard2,
    Assets.assetsOnboard3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: [
          Colors.white,
          Color.fromRGBO(252, 234, 230, 1),
          Colors.white,
        ],
        nextButtonBuilder: (context) {
          return Icon(Icons.arrow_forward_ios);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/login');
        },
        itemCount: images.length,
        itemBuilder: (index) {
          return Image.asset(images[index]);
        },
      ),
    );
  }
}
