// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:august_plus/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../../src/size_configuration.dart';
import '../../../../utils/loading_dialog.dart';
import '../profile/profile.dart';

class NewUserScreenOtp extends StatefulWidget {
  final String phone;
  const NewUserScreenOtp({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<NewUserScreenOtp> createState() => _NewUserScreenOtpState();
}

class _NewUserScreenOtpState extends State<NewUserScreenOtp> {
  TextEditingController otpController1 = TextEditingController();
  String verificationId = "";
  String smsCode = "";
  //AuthClass authClass = AuthClass();
  bool issend = false;
  int start = 30;
  void setTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          issend = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void validate() async {
    if (otpController1.text.isNotEmpty && otpController1.text.length == 6) {
      showDialog(
          context: context,
          builder: (context) {
            //  print("loading screen");
            return const LoadingDialog(
              message: "Please Wait",
            );
          });
      // print("authenticate");
      await authenticate1();
    }
  }

  Future<void> authenticate1() async {
    UserCredential userCredential = await authClass.signInWithPhoneNumber(
      verificationId,
      smsCode,
      context,
      widget.phone,
    );
    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      if (kDebugMode) {
        print('User cred...........................................');
        print(userCredential);
      }
      if (kDebugMode) {
        print("Sending user to profile page to save details");
      }
      sharedPreferences.setString("phone", widget.phone);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(phone: widget.phone),
        ),
      );
      // getDataAndSaveLocally();
      setState(() {
        start = 0;
      });
    } else {
      Navigator.pop(context);
      showSnackBar(context, 'Wrong OTP entered', Colors.red);
    }
    //   //TODOS: 1. Retrieve user info from firebase.
    //   //TODOS: 2. Save locally also
  }

  @override
  void initState() {
    // setTimer();
    super.initState();

    //TODOS:1
    authClass.verifyPhoneNumber(
      "+91 ${widget.phone}",
      context,
      setData,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9900),
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: getProportionateScreenHeight(400),
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFFFF9900),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(40),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   bottom: getProportionateScreenHeight(400),
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 20,
          //     color: const Color(0xFFFF9900),
          //     //child: Image.asset('assets/images/otp.png'),
          //   ),
          // ),
          Positioned(
            top: getProportionateScreenHeight(400),
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
            top: getProportionateScreenHeight(150),
            bottom: getProportionateScreenHeight(200),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                  ),
                  Text(
                    "OTP has been sent to your registered mobile number",
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12.0,
                        fontFamily: "VarelaRound",
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Text(
                      "******${widget.phone.substring(6)}",
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  OTPTextField(
                    // controller: otpController1,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40,
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      if (kDebugMode) {
                        print("Completed Pin$pin");
                      }
                      setState(() {
                        smsCode = pin;
                        otpController1.text = pin;
                      });
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                issend
                                    ? {
                                        //resend otp
                                        authClass.signInWithPhoneNumber(
                                          verificationId,
                                          smsCode,
                                          context,
                                          // widget.userName,
                                          widget.phone,
                                        ),
                                        // ignore: avoid_print
                                        print("resend otp"),
                                        start = 30,
                                        issend = false,
                                        setTimer(),
                                      }
                                    : {
                                        const SnackBar(
                                          content:
                                              Text("Please wait until timer"),
                                        ),
                                        // ignore: avoid_print
                                        print("Please wait until timer"),
                                      };
                              },
                            text: "Resend OTP in",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: issend ? Colors.blue : Colors.grey,
                            ),
                          ),
                          const TextSpan(
                            text: "in",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "00:$start",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.pink,
                            ),
                          ),
                          const TextSpan(
                            text: " sec",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          validate();
                        },
                        child: const Text('Continue and SignUp'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setData(String verificationsId) {
    setState(() {
      verificationId = verificationsId;
    });
    setTimer();
  }
}
