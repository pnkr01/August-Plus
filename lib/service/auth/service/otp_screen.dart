import 'package:flutter/material.dart';

import '../components/new_user/new_otp_screen.dart';
import '../components/old_user/old_otp_screen.dart';

//TODOS: if we have newUser True --->
//TODOS: 1. Save user info to firebase.
//TODOS: 2. Save locally also

//TODOS: if we have newUser False --->
//TODOS: 1. Retrieve user info from firebase.
//TODOS: 2. Save locally also.

class OTPScreen extends StatefulWidget {
  final String phonenumber;
  final bool isNewUser;
  const OTPScreen({
    Key? key,
    required this.phonenumber,
    required this.isNewUser,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF091637),
      body: widget.isNewUser
          ? NewUserScreenOtp(
              phone: widget.phonenumber,
            )
          //TODOS : CREATE ACCOUNT, IF USER IS NEW..
          : OldUserScreenOtp(
              phone: widget.phonenumber,
            ),
    );
  }
}
