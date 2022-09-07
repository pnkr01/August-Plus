import 'package:august_plus/service/DS/decision_screen.dart';
import 'package:flutter/material.dart';

import '../../../package/custom_splash_screen.dart';
import '../design/splash_content.dart';

List<Map<String, String>> splashData = [
  {
    'image': 'assets/images/two.jpg',
    'text': 'Take NearBy Doctors Appointement Online',
  },
  {
    'image': 'assets/images/four.webp',
    'text': 'Digitally Manage all your health checkups data',
  },
  {
    'image': 'assets/images/six.jpg',
    'text': 'Book Ambulance Service and check their real-time location',
  },
];

List<Color> color = [
  Colors.white,
  Colors.white,
  Colors.white,
  const Color(0xFFEFE0F3),
];

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurvedSplashScreen(
        backText: "Back",
        backgroundColor: Colors.white,
        screensLength: splashData.length,
        screenBuilder: (index) {
          return SplashContent(
            image: splashData[index]["image"],
            text: splashData[index]["text"],
            color: color[index],
          );
        },
        onSkipButton: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DecisionScreen()));
        },
      ),
    );
  }
}
