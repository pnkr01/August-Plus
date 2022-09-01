import 'package:august_plus/src/screen/pages/bottom_nav/home/components/home_second_container/home_upper_second_container.dart';
import 'package:flutter/material.dart';
import 'components/home_third_container/home_upper_third_container.dart';
import 'components/home_upper/upper_container.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HomeUpperContainer(),
                HomeUpperSecondContainer(),
                HomeUpperThirdContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
