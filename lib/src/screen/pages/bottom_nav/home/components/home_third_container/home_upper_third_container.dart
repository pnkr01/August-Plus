import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'design_weather.dart';

class HomeUpperThirdContainer extends StatefulWidget {
  final Weather wdata;
  const HomeUpperThirdContainer({
    Key? key,
    required this.wdata,
  }) : super(key: key);

  @override
  State<HomeUpperThirdContainer> createState() =>
      _HomeUpperThirdContainerState();
}

class _HomeUpperThirdContainerState extends State<HomeUpperThirdContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '    Weather in ${widget.wdata.areaName.toString()}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See More'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DesignWeather(wData: widget.wdata),
        ),
      ],
    );
  }
}
