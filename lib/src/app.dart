import 'dart:async';
import 'package:august_plus/src/screen/home/home.dart';
import 'package:august_plus/src/screen/login/login.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'constant/global.dart';
import 'screen/splash/components/splash_body.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      title: 'Doctor Plus',
      home: const HandleOnboarding(),
      routes: {
        '/home': (context) => const Home(),
        '/splash': (context) => const SplashBody(),
        '/login': (context) => const LogInCumSignUpScreen(),
      },
    );
  }
}

class HandleOnboarding extends StatefulWidget {
  const HandleOnboarding({Key? key}) : super(key: key);

  @override
  State<HandleOnboarding> createState() => _HandleOnboardingState();
}

class _HandleOnboardingState extends State<HandleOnboarding> {
  @override
  void initState() {
    setTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFB7C8FE),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/one.jpg'),
          Center(
            child: Text(
              'August',
              style: splashTextStyle(),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(40.0),
          ),
          const CircularProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void setTimer() {
    Timer(const Duration(seconds: 2), () {
      if (firebaseAuth.currentUser != null) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/splash');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const SplashBody()));
      }
    });
  }
}
