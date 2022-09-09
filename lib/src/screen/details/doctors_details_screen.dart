import 'package:august_plus/utils/progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/global.dart';
import 'package:august_plus/utils/loading_dialog.dart';

bool? isBooked;

class DoctorDetailScreen extends StatefulWidget {
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
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    isBooked = sharedPreferences.getBool(widget.id) ?? false;
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 40.0,
                  right: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
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
                          widget.expt,
                          style: textStyle().copyWith(
                            color: const Color.fromARGB(255, 124, 120, 120),
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CachedNetworkImage(
                          width: 100,
                          imageUrl: widget.docImage,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  circularProgress(),
                        ),
                        //  Image.network(
                        //   widget.docImage,
                        //   width: 100,
                        // ),
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
                        "${widget.patient} +",
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
                          widget.exp,
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
                        "${widget.rating} .0",
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
                      widget.desc,
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
                primary: isBooked! ? Colors.grey : kPrimaryColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                !isBooked!
                    ? showDialog(
                        context: context,
                        builder: ((context) =>
                            const LoadingDialog(message: 'Please Wait')))
                    : null;
                isBooked!
                    ? showSnackBar(
                        context,
                        'you have booked this today at ${DateTime.now().toIso8601String().substring(12, 16)}',
                        Colors.red,
                      )
                    : {
                        await bookAppointement(context, widget.id),
                        setState(() {
                          sharedPreferences.setBool(widget.id, true);
                        }),
                      };
              },
              child: isBooked!
                  ? const Text('Booked')
                  : const Text('Book Appointemet'),
            ),
          ),
        ],
      ),
    );
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
      sharedPreferences.setBool(id, true);
      Navigator.pop(context);
      showSnackBar(
        context,
        'Booked Sucessfully',
        Colors.green,
      );
    });
  }
}
