import 'package:august_plus/src/constant/shimmer.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/doctor_card.dart';

class HomeUpperSecondContainer extends StatelessWidget {
  const HomeUpperSecondContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream stream = FirebaseFirestore.instance.collection('doctor').snapshots();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '  Doctor of the week',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See More'),
            )
          ],
        ),
        StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const NewsCardSkelton();
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      snapshot.data.docs.length,
                      (index) {
                        return DoctorCard(
                          doctImage: snapshot.data.docs[index]['img'],
                          width: 200,
                          name: snapshot.data.docs[index]['name'],
                          address: snapshot.data.docs[index]['add'],
                          experience: snapshot.data.docs[index]['exp'],
                          expertise: snapshot.data.docs[index]['et'],
                          hp: snapshot.data.docs[index]['hp'],
                          rating: snapshot.data.docs[index]['ra'],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
