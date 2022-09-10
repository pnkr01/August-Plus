// ignore_for_file: use_build_context_synchronously

import 'package:august_plus/src/screen/pages/bottom_nav/home/components/home_four/home_four_container.dart';
import 'package:august_plus/src/screen/pages/bottom_nav/home/components/home_second_container/home_upper_second_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import '../../../../../utils/global.dart';
import '../../../../constant/shimmer.dart';
import '../../../../video/model/data_store.dart';
import '../../../../video/model/meeting_lin.dart';
import '../../../../video/service/join_service.dart';
import '../../../../video/service/sdk_intializer.dart';
import 'components/home_third_container/home_upper_third_container.dart';
import 'components/home_upper/upper_container.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  late UserDataStore _dataStore;
  bool _isLoading = false;
  Future<bool> joinRoom() async {
    setState(() {
      _isLoading = true;
    });
    bool isJoinSuccessful = await JoinService.join(SDKIntializer.hmssdk);
    if (!isJoinSuccessful) {
      return false;
    }
    _dataStore = UserDataStore();
    _dataStore.startListen();
    setState(() {
      _isLoading = false;
    });
    return true;
  }

  bool isLoading = true;
  late WeatherFactory wf;
  late Weather w;
  @override
  void initState() {
    wf = WeatherFactory(
      "752c76ba36af06e471e0cb73908fa033",
      language: Language.ENGLISH,
    );
    checkWeather();
    super.initState();
  }

  checkWeather() async {
    await takeWeather();
  }

  Future<Weather> takeWeather() async {
    w = await wf
        .currentWeatherByLocation(
      sharedPreferences.getDouble('lat') ?? 0.0,
      sharedPreferences.getDouble('long') ?? 0.0,
    )
        .then((w) {
      sharedPreferences.setString('place', w.areaName ?? 'area not found');
      sharedPreferences.setString(
          'weather', w.weatherDescription ?? 'weather not found');
      sharedPreferences.setDouble('humidity', w.humidity ?? 20.0);
      sharedPreferences.setDouble('windSpeed', w.windSpeed ?? 30.0);
      sharedPreferences.setDouble(
          'tempFeelsLike', w.tempFeelsLike!.celsius ?? 30.0);
      sharedPreferences.setDouble('pressure', w.pressure ?? 30.0);
      sharedPreferences.setString('icon', w.weatherIcon ?? 'null');

      sharedPreferences.setBool('setData', true);
      setState(() {
        isLoading = !isLoading;
      });
      return w;
    });
    if (kDebugMode) {
      print("weather done");
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoading
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HomeUpperContainer(),
                      const HomeUpperSecondContainer(),
                      ElevatedButton(
                          onPressed: () async {
                            bool isJoined = await joinRoom();
                            if (isJoined) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ListenableProvider.value(
                                    value: _dataStore,
                                    child: const MeetingScreen(),
                                  ),
                                ),
                              );
                            } else {
                              const SnackBar(content: Text("Error"));
                            }
                          },
                          child: const Text('Text')),
                      HomeUpperThirdContainer(wdata: w),
                      const HomeFourContainer(),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
              ),
            ),
    );
  }
}
