import 'package:august_plus/src/app.dart';
import 'package:august_plus/utils/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}



//TODOS : WORK ON DETAILS DOCCTOR SCREEN, BOOK SECTION AND HOME DOC OPTION + IONS CLASS A,H,H,rEPORT
//6-9-2022