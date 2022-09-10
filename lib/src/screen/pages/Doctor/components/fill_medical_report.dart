import 'dart:developer';

import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/errordialog.dart';
import 'package:august_plus/utils/global.dart';
import 'package:august_plus/utils/loading_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:august_plus/src/constant/constant.dart';

import '../../../../../utils/progress_bar.dart';

class FillMedical extends StatefulWidget {
  final String name;
  final String number;
  const FillMedical({
    Key? key,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  State<FillMedical> createState() => _FillMedicalState();
}

class _FillMedicalState extends State<FillMedical> {
  TextEditingController describeController = TextEditingController();
  TextEditingController medicineCntroller = TextEditingController();
  TextEditingController precautionCntroller = TextEditingController();
  String checSelcted = 'Normal';
  List checkUptype = [
    'Normal',
    'Heart',
    'Lungs',
    'Eye',
    'Stomach',
    'Hair',
    'Stomach',
    'Emgergency',
    'Others',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Fill Report',
          style: textStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "You are filling report of ${widget.name}",
                style: textStyle().copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 140,
              width: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: CachedNetworkImage(
                  width: 100,
                  alignment: Alignment.topRight,
                  fit: BoxFit.fill,
                  imageUrl:
                      'https://cdn.dribbble.com/users/428469/screenshots/17502123/media/2b9f95631f185d0fa1dad09f09506a4f.jpg?compress=1&resize=1000x750&vertical=top',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      circularProgress(),
                ),
                // Image.network(
                //   doctImage,
                // alignment: Alignment.topRight,
                // fit: BoxFit.fill,
                // ),
              ),
            ),
            // Image.network(
            // 'https://cdn.dribbble.com/users/428469/screenshots/17502123/media/2b9f95631f185d0fa1dad09f09506a4f.jpg?compress=1&resize=1000x750&vertical=top',
            // ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 0.80,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    items: checkUptype
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (item) => setState(() {
                      checSelcted = item as String;
                      log(checSelcted);
                    }),
                    value: checSelcted,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: describeController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Describe the problem *',
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: medicineCntroller,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Describe Medicine given *',
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: precautionCntroller,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Precaution and things not to eat *',
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 10.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => submitReport(widget.number),
                  child: Text(
                    'Submit Report',
                    style: textStyle().copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  submitReport(String num) {
    if (describeController.text.isNotEmpty &&
        medicineCntroller.text.isNotEmpty &&
        precautionCntroller.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: ((context) {
            return const LoadingDialog(message: 'Please wait');
          }));
      writeReportToDocAndPat(num);
    } else {
      showDialog(
        context: context,
        builder: ((context) =>
            const ErrorDialog(message: 'Please fill all blanks')),
      );
    }
  }

  writeReportToDocAndPat(String num) async {
    await FirebaseFirestore.instance
        .collection('phone')
        .doc(num)
        .collection('reports')
        .doc()
        .set({
          'type': describeController.text,
          'problem': precautionCntroller.text,
          'medicine': medicineCntroller.text,
          'precaution': precautionCntroller.text,
        })
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('doctors')
                  .doc(sharedPreferences.getString('phone')!.substring(0, 1))
                  .collection('reportsGiven')
                  .doc(num)
                  .set({
                'type': describeController.text,
                'problem': precautionCntroller.text,
                'medicine': medicineCntroller.text,
                'precaution': precautionCntroller.text,
              })
            })
        .then(
          (value) {
            log(sharedPreferences.getString('phone')!.substring(0, 1));
            FirebaseFirestore.instance
                .collection('doctors')
                .doc(
                  sharedPreferences.getString('phone')!.substring(0, 1),
                )
                .collection('pat')
                .doc(num)
                .delete()
                .then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
        );
  }
}
