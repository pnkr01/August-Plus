import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../src/size_configuration.dart';
import '../../../utils/global.dart';
import '../../../utils/loading_dialog.dart';
import '../service/otp_screen.dart';

class SignInCumLogInScreen extends StatefulWidget {
  const SignInCumLogInScreen({Key? key}) : super(key: key);

  @override
  State<SignInCumLogInScreen> createState() => _SignInCumLogInScreen();
}

class _SignInCumLogInScreen extends State<SignInCumLogInScreen> {
  TextEditingController phoneController = TextEditingController();
  //TODOS: VALIDATE FORM
  void validateForm() async {
    if (phoneController.text.length == 10) {
      sharedPreferences.setString('phone', phoneController.text);
      showDialog(
          //barrierDismissible: false,
          context: context,
          builder: (context) {
            return const LoadingDialog(
              message: "",
            );
          });
      checkUserExistOrNot();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Column(
          children: [
            const ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.red,
              ),
              title: Text('Number should be of 10 digits.'),
            ),
            SizedBox(
              width: double.infinity - 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('close'),
              ),
            ),
          ],
        )),
      ); //
    }
  }

  //TODOS: validate Ends

  //TODOS: CHECKUSER START

  void checkUserExistOrNot() async {
    await FirebaseFirestore.instance
        .collection("phone")
        .doc(phoneController.text)
        .get()
        .then((value) async {
      if (value.exists) {
        if (kDebugMode) {
          print("Number exist on backend");
        }
        //if user is  already there in firebase
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => OTPScreen(
              phonenumber: phoneController.text,
              isNewUser: false,
              //false means user data will be there in firestore,fetch data
              //from there and saved to sharedpref to use locally.
            ),
            //send true to otpscreen
          ),
        );
      } else {
        if (kDebugMode) {
          print("Number not exist");
        }
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => OTPScreen(
              phonenumber: phoneController.text,
              isNewUser: true,
              //false means user data will be there in firestore,fetch data
              //from there and saved to sharedpref to use locally.
            ),
            //send true to otpscreen
          ),
        );
      }
    });
  }

//TODOS: CHECK USER ENDS

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
              child: Text(
                '            Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(40),
                ),
              ),
            ),
          ),
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
                  const Text('Enter Mobile Number'),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      cursorHeight: 20,
                      decoration: const InputDecoration(
                        prefixText: "+91",
                        labelText: "Phone",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: const Text('Request OTP'),
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
}
