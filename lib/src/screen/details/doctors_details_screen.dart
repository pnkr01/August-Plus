import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(75),
            ),
            Text(
              'Doctor Details',
              style: textStyle(),
            )
          ],
        ),
      ),
      body: Stack(children: [
        Positioned(
          bottom: getProportionateScreenHeight(550),
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 20,
          right: 20,
          bottom: 480,
          child: Container(
            decoration: decoration(),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Dr D.K Singhal',
                        style: textStyle().copyWith(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Child Specialist',
                        style: textStyle().copyWith(
                          color: const Color.fromARGB(255, 124, 120, 120),
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Image.network(
                    "https://img.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_1303-29791.jpg?w=1060&t=st=1662569329~exp=1662569929~hmac=20a080f1046275b94c1fc7a5a05610387887a0ca8351cb4576f7ac7130a1b5d8",
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 250,
            left: 20,
            right: 20,
            bottom: 350,
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: size.width / 3.8,
                  decoration: decoration(),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 100,
                  width: size.width / 3.8,
                  decoration: decoration(),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 100,
                  width: size.width / 3.8,
                  decoration: decoration(),
                ),
              ],
            )
            // SingleChildScrollView(
            //   child: Row(
            //     children: List.generate(
            //       3,
            //       (index) => boxContainerForDoctors(),
            //     ),
            //   ),
            // ),
            )
      ]),
    );
  }
}

boxContainerForDoctors() {
  return Column(
    children: [
      Container(
        height: 50,
        width: double.infinity,
        color: Colors.red,
      ),
      SizedBox(
        width: getProportionateScreenWidth(20),
      )
    ],
  );
}
