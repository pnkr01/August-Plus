import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../../../../../../package/weather_icon.dart';

class DesignWeather extends StatelessWidget {
  final Weather wData;

  const DesignWeather({Key? key, required this.wData}) : super(key: key);

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(6, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 5),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 35,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height /
          getProportionateScreenHeight(3.5),
      width: MediaQuery.of(context).size.width,
      child: GridView(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          _gridWeatherBuilder(
              '${wData.humidity}%', 'Humidity', WeatherIcons.wiRaindrop),
          _gridWeatherBuilder(
              '${wData.windSpeed} km/h', 'Wind', WeatherIcons.wiStrongWind),
          _gridWeatherBuilder(
              '${wData.tempFeelsLike.toString().substring(0, 5)}°C',
              'Feels Like',
              WeatherIcons.wiCelsius),
          _gridWeatherBuilder(
            '${wData.pressure} Pa',
            'Pressure',
            WeatherIcons.wiBarometer,
          ),
        ],
      ),
    );
  }
}
