// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:august_plus/src/screen/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../src/screen/pages/Doctor/doctor_home.dart';
import '../../../../src/size_configuration.dart';
import '../../../../utils/global.dart';
import '../../../../utils/loading_dialog.dart';

class OldUserScreenOtp extends StatefulWidget {
  final String phone;
  const OldUserScreenOtp({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OldUserScreenOtp> createState() => _OldUserScreenOtpState();
}

class _OldUserScreenOtpState extends State<OldUserScreenOtp> {
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
        timer.cancel();
        if (mounted) {
          setState(() {
            issend = !issend;
          });
        }
      } else {
        setState(() {
          if (mounted) {
            start--;
          }
        });
      }
    });
  }

  void validate() async {
    if (otpController1.text.isNotEmpty && otpController1.text.length == 6) {
      showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog(
              message: "Please Wait",
            );
          });
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
      // ignore: avoid_print
      print("saving data locallyyyyy");
      getDataAndSaveLocally();
      setState(() {
        start = 0;
      });
    } else {
      Navigator.pop(context);
      showSnackBar(context, 'Wrong OTP entered', Colors.red);
    }
  }

  Future<void> getDataAndSaveLocally() async {
    if (sharedPreferences.getString('role') == 'Patient' ||
        sharedPreferences.getString('role') == null) {
      await FirebaseFirestore.instance
          .collection("phone")
          .doc(widget.phone)
          .get()
          .then((snap) async {
        // await  sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences.setString("name", snap.data()!["name"]);
        await sharedPreferences.setString("phone", snap.data()!["phone"]);
        await sharedPreferences.setString("role", snap.data()!["role"]);
        await sharedPreferences.setString("email", snap.data()!["email"]);
        await sharedPreferences.setString("address", snap.data()!["address"]);

        await sharedPreferences.setInt("age", snap.data()!["age"]);
        await sharedPreferences.setString("gender", snap.data()!["gender"]);
      }).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        showSnackBar(context, "LoggedIn Sucessfully", Colors.green);
      });
    } else {
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(widget.phone.substring(0, 1))
          .get()
          .then((snap) async {
        // await  sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences.setString("name", snap.data()!["name"]);
        await sharedPreferences.setString("phone", widget.phone);
        await sharedPreferences.setString("rating", snap.data()!["ra"]);
        await sharedPreferences.setString("address", snap.data()!["add"]);
        await sharedPreferences.setString("desc", snap.data()!["description"]);
        await sharedPreferences.setString("et", snap.data()!["et"]);
        await sharedPreferences.setString("exp", snap.data()!["exp"]);
        await sharedPreferences.setString("hp", snap.data()!["hp"]);
        await sharedPreferences.setString("img", snap.data()!["img"]);
      }).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DoctorHomePage(),
          ),
        );
        showSnackBar(context, 'LoggedIn Sucessfully', Colors.green);
      }).then((value) {
        setState(() {
          start = 0;
        });
      });
    }
  }

  @override
  void initState() {
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
                    'Log In',
                    style: GoogleFonts.inder(
                      color: Colors.white,
                      fontSize: 28.0,
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
                        child: const Text('Continue and LogIn'),
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
