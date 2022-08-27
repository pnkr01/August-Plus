import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../size_configuration.dart';
import '../pages/ambulance/ambulance_nav.dart';
import '../pages/appointement/appointement_nav.dart';
import '../pages/home/home_nav.dart';
import '../pages/message/message_nav.dart';
import '../pages/profile/profile_nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final screen = [
    const HomeNav(),
    const MessageNav(),
    const AmbulanceNav(),
    const ApoointementNav(),
    const ProfileNav(),
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
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: FontAwesomeIcons.house,
                  // text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  //text: 'Messages',
                ),
                GButton(
                  icon: FontAwesomeIcons.truckMedical,
                  // text: 'Ambulance',
                ),
                GButton(
                  icon: FontAwesomeIcons.calendar,
                  //text: 'Appointement',
                ),
                GButton(
                  icon: FontAwesomeIcons.person,
                  // text: 'Profile',
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
      body: screen[_selectedIndex],
    );
  }
}
