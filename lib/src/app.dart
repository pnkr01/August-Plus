import 'dart:async';
import 'package:august_plus/src/screen/home/home.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/src/theme/app_theme.dart';
import 'package:august_plus/utils/errordialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/weather.dart';
import '../service/auth/components/signin.dart';
import '../utils/global.dart';
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
        '/login': (context) => const SignInCumLogInScreen(),
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
  late WeatherFactory wf;
  @override
  void initState() {
    super.initState();

    setTimer();
    requestPermission();
    wf = WeatherFactory(
      "752c76ba36af06e471e0cb73908fa033",
      language: Language.ENGLISH,
    );
  }

  // takeWeather() async {
  //   await wf
  //       .currentWeatherByLocation(
  //     sharedPreferences.getDouble('lat') ?? 0.0,
  //     sharedPreferences.getDouble('long') ?? 0.0,
  //   )
  //       .then((w) {
  //     sharedPreferences.setString('place', w.areaName ?? 'area not found');
  //     sharedPreferences.setString(
  //         'weather', w.weatherDescription ?? 'weather not found');
  //     sharedPreferences.setDouble('humidity', w.humidity ?? 20.0);
  //     sharedPreferences.setDouble('windSpeed', w.windSpeed ?? 30.0);
  //     sharedPreferences.setDouble(
  //         'tempFeelsLike', w.tempFeelsLike!.celsius ?? 30.0);
  //     sharedPreferences.setDouble('pressure', w.pressure ?? 30.0);
  //     sharedPreferences.setString('icon', w.weatherIcon ?? 'null');
  //     return w;
  //   });
  // }

  var currentLocation;

  requestPermission() async {
    // ignore: avoid_print
    print("Asking Permission");
    await Permission.location.request();
    await chekForPermission();
    //await takeWeather();
  }

  chekForPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      // ignore: avoid_print
      print("Got Permission from User");
      if (sharedPreferences.getDouble("lat") == null &&
          sharedPreferences.getDouble("long") == null) {
        getLocation();
        if (kDebugMode) {
          print("Calling get location");
        }
      }
    } else {
      const ErrorDialog(
        message: 'We want this to give you some geographical service',
      );
    }
    //TODOS :HANDLE PERMISSION
  }

  void getLocation() {
    Geolocator.getCurrentPosition().then((currrloc) async {
      currentLocation = currrloc;
      // ignore: avoid_print
      print("Got the location");
      await sharedPreferences.setDouble("lat", currentLocation.latitude);
      await sharedPreferences.setDouble("long", currentLocation.longitude);
      print(sharedPreferences.getDouble('lat'));
      print(sharedPreferences.getDouble('long'));
    });
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
