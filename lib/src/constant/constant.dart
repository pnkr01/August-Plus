import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFFFF9900);
const kSecondaryColor = Color(0xFF979797);
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
