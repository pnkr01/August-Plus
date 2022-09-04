import 'package:flutter/material.dart';

import 'components/map_page.dart';
import 'components/top_header.dart';

class AmbulanceNav extends StatelessWidget {
  const AmbulanceNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  drawer: const NavigationDrawerWidget(),
      body: Stack(children: const [
        Positioned.fill(
          child: MapPage(),
        ),
        TopHeader(),
      ]),
    );
  }
}
