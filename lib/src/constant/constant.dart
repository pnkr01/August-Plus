import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color.fromARGB(255, 74, 78, 194);
const kSecondaryColor = Color(0xFF8E8BE1);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);
const kdefaultDuration = Duration(milliseconds: 250);

const ksplashText = "August";
const ksplashTextSize = 50.0;

TextStyle textStyle() {
  return GoogleFonts.robotoSlab(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(20),
  );
}

BoxDecoration decoration() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
    color: Color(0xFFFFFDFF),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 234, 230, 230),
        offset: Offset(0, 2),
      ),
      BoxShadow(
        color: Color.fromARGB(255, 234, 230, 230),
        offset: Offset(0, -2),
      ),
      BoxShadow(
        color: Color.fromARGB(255, 234, 230, 230),
        offset: Offset(1, 0),
      ),
      BoxShadow(
        color: Color.fromARGB(255, 234, 230, 230),
        offset: Offset(-1, 0),
      ),
    ],
  );
}
