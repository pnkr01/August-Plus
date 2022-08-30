import 'package:august_plus/src/screen/pages/bottom_nav/home/components/home_upper_second_container.dart';
import 'package:flutter/material.dart';

import 'components/home_upper_third_container.dart';
import 'components/home_upper/upper_container.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            HomeUpperContainer(),
            HomeUpperSecondContainer(),
            HomeUpperThirdContainer(),
          ],
        ),
      ),
    );
  }
}
