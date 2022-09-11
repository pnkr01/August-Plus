import 'package:august_plus/src/screen/pages/bottom_nav/profile/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../size_configuration.dart';
import '../pages/bottom_nav/ambulance/ambulance_nav.dart';
import '../pages/bottom_nav/home/home_nav.dart';
import '../pages/bottom_nav/message/components/ai_bot_dc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final screen = [
    const HomeNav(),
    const AIBotDecision(),
    const Profile1(),
    const AmbulanceNav(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GNav(
                rippleColor: Colors.blue[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: const Color(0xFF5E63E0),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: const Color(0xFFC9C9C9),
                tabs: const [
                  GButton(
                    icon: FontAwesomeIcons.house,
                    text: 'Home',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.bolt,
                    text: 'AI BOT',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.person,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.truckMedical,
                    text: 'Ambulance',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: screen[_selectedIndex],
    );
  }
}
