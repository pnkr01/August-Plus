import 'package:august_plus/src/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/global.dart';
import '../../../constant/shimmer.dart';

class ReportSection extends StatelessWidget {
  const ReportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        children: const [],
      ),
    );
  }
}

Widget upHistoryEvent() {
  Stream stream = FirebaseFirestore.instance
      .collection('phone')
      .doc(sharedPreferences.getString('phone'))
      .collection('reports')
      .snapshots();
  return StreamBuilder(
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
                  return Container();
                  // return DesignEvent(
                  //   name: snapshot.data.docs[index]['doctName'],
                  //   expt: snapshot.data.docs[index]['docExpt'],
                  //   docImg: snapshot.data.docs[index]['img'],
                  //   date: snapshot.data.docs[index]['date'],
                  //   time: snapshot.data.docs[index]['time'],
                  // );
                },
              ),
            ],
          ),
        );
      }
    },
  );
}
