import 'dart:math';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/screen/details/report/components/detail_repost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/global.dart';
import '../../../constant/shimmer.dart';
import 'components/design_report.dart';

final List<Color> color = [
  Colors.blue,
  Colors.amber,
  Colors.pink,
  Colors.red,
  Colors.purple,
];

class ReportSection extends StatelessWidget {
  const ReportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream stream = FirebaseFirestore.instance
        .collection('phone')
        .doc(sharedPreferences.getString('phone'))
        .collection('reports')
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(
            'Report',
            style: textStyle(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: textStyle().copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notification_add_outlined,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 100,
                decoration: decoration().copyWith(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(0.0)),
                child: Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, top: 10),
                    //   child: SvgPicture.asset(
                    //     'assets/images/a.svg',
                    //     alignment: Alignment.topLeft,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/a.png'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Flexible(
                      child: Text(
                        'You are getting closer to healthy life',
                        style: textStyle()
                            .copyWith(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reports',
                    style: textStyle().copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                    stream: stream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const NewsCardSkelton();
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                snapshot.data.docs.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => DetailReport(
                                              medicine: snapshot
                                                  .data.docs[index]['medicine'],
                                              precaution: snapshot.data
                                                  .docs[index]['precaution'],
                                              problem: snapshot.data.docs[index]
                                                  ['problem'],
                                              type: snapshot.data.docs[index]
                                                  ['type'],
                                            )),
                                      ),
                                    ),
                                    child: ReportDesign(
                                      color: color[Random().nextInt(5)],
                                      docName: snapshot.data.docs[index]
                                          ['docName'],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 20,
            //     right: 20,
            //     top: 20,
            //   ),
            //   child: Container(
            //     height: 100,
            //     decoration: decoration().copyWith(
            //       border: Border.all(
            //         color: Colors.grey,
            //       ),
            //     ),
            //     child: ,
            //   ),
            // ),
          ],
        )

        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       StreamBuilder(
        //         stream: stream,
        //         builder: (context, AsyncSnapshot snapshot) {
        //           if (!snapshot.hasData) {
        //             return const NewsCardSkelton();
        //           } else {
        //             return SingleChildScrollView(
        //               scrollDirection: Axis.vertical,
        //               child: Column(
        //                 children: [
        //                   ...List.generate(
        //                     snapshot.data.docs.length,
        //                     (index) {
        //                       return ReportDesign(
        //                         medicine: snapshot.data.docs[index]['medicine'],
        //                         precaution: snapshot.data.docs[index]
        //                             ['precaution'],
        //                         problem: snapshot.data.docs[index]['problem'],
        //                         type: snapshot.data.docs[index]['type'],
        //                       );
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             );
        //           }
        //         },
        //       ),
        //       const SizedBox(),
        //     ],
        //   ),
        // ),
        );
  }
}
