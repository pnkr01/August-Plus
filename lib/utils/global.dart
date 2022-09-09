import 'package:august_plus/src/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/auth/service/authservices.dart';

late SharedPreferences sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
AuthClass authClass = AuthClass();
void showSnackBar(BuildContext context, String text, Color? color) {
  final snakbar = SnackBar(
    backgroundColor: color ?? kPrimaryColor,
    duration: const Duration(seconds: 1),
    content: Text(text),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snakbar);
}
