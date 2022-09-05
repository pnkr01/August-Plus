import 'package:august_plus/src/screen/pages/bottom_nav/ambulance/components/design/design_ambulance.dart';
import 'package:august_plus/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constant/shimmer.dart';

class BookedAmbulancePage extends StatelessWidget {
  const BookedAmbulancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream stream = FirebaseFirestore.instance
        .collection('phone')
        .doc(sharedPreferences.getString('phone'))
        .collection('ambulance')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text(
          'Booked Ambulance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 78, 152),
      ),
      body: StreamBuilder(
        stream: stream,
        builder: ((context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const NewsCardSkelton();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: ((context, index) {
                return DesignAmbulanceCard(
                    address: snapshot.data.docs[index]['address'],
                    distance: snapshot.data.docs[index]['distance'],
                    name: snapshot.data.docs[index]['name']);
                // return Text(snapshot.data.docs[index]['name']);
              }),
            );
          }
        }),
      ),
    );
  }
}
