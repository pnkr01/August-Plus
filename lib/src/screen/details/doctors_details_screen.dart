import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/global.dart';
import 'package:august_plus/utils/loading_dialog.dart';

class DoctorDetailScreen extends StatelessWidget {
  final String id;
  final String name;
  final String desc;
  final String docImage;
  final String patient;
  final String exp;
  final String expt;
  final String rating;
  const DoctorDetailScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.desc,
    required this.docImage,
    required this.patient,
    required this.exp,
    required this.expt,
    required this.rating,
  }) : super(key: key);

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
      body: Stack(
        children: [
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
                          name,
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
                          expt,
                          style: textStyle().copyWith(
                            color: const Color.fromARGB(255, 124, 120, 120),
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Image.network(docImage),
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Patients',
                        style: textStyle()
                            .copyWith(color: Colors.grey, fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        patient,
                        style: textStyle().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 100,
                  width: size.width / 3.8,
                  decoration: decoration(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Experience',
                        style: textStyle()
                            .copyWith(color: Colors.grey, fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        SizedBox(
                          width: size.width / 28,
                        ),
                        Text(
                          exp,
                          style: textStyle().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' Years',
                          style: textStyle().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 100,
                  width: size.width / 3.8,
                  decoration: decoration(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rating',
                        style: textStyle()
                            .copyWith(color: Colors.grey, fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        rating,
                        style: textStyle().copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 380,
            left: 20,
            right: 20,
            bottom: 100,
            child: Container(
              height: 50,
              decoration: decoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Doctors',
                      style: textStyle().copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: Text(
                      desc,
                    )),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 650,
            left: 20,
            right: 20,
            bottom: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) =>
                        const LoadingDialog(message: 'Please Wait')));
                bookAppointement(context, id);
              },
              child: const Text('Book Appointemet'),
            ),
          ),
        ],
      ),
    );
  }
}

bookAppointement(BuildContext context, String id) async {
  await FirebaseFirestore.instance
      .collection('doctors')
      .doc(id)
      .collection('pat')
      .doc()
      .set({
    'patname': sharedPreferences.getString('name'),
    'patnum': sharedPreferences.getString('phone'),
  }).then((value) {
    Navigator.pop(context);
    showSnackBar(
      context,
      'Booked Sucessfully',
    );
  });
}
