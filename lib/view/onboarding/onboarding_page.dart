import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/tools.dart';

import '../../core/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<String> images = [
    Assets.assetsOnboard3,
    Assets.assetsOnboard1,
    Assets.assetsOnboard2,
  ];
  late final PageController _controller;
  int currentIndex = 0;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              currentIndex = index;
              setState(() {});
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withAlpha(100),
                      BlendMode.darken,
                    ),
                    child: Image.asset(
                      images[index],
                      height: 1000,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sign ',
                            style: tstyle(context).headlineMedium!.copyWith(
                                  color: yellowAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'Language\nGot so easy',
                            style: tstyle(context).headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Skip'),
                  ),
                ),
                hSpace(2),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (checkIfLastPage) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool get checkIfLastPage => currentIndex == images.length - 1;
}
