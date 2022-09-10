import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../constant/shimmer.dart';
import 'components/detail_gov_screen.dart';
import 'components/govt_cards.dart';

Stream stream = FirebaseFirestore.instance.collection('gov').snapshots();

class HomeFourContainer extends StatelessWidget {
  const HomeFourContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '    Gov Health Awarness',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('See More'))
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
                        return GestureDetector(
                          onTap: (() {
                            log('clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => DetailGovScreen(
                                      title: snapshot.data.docs[index]['title'],
                                      describe: snapshot.data.docs[index]
                                          ['describe'],
                                      imgLink: snapshot.data.docs[index]['img'],
                                    )),
                              ),
                            );
                          }),
                          child: DesignGovHealthCard(
                            imgLink: snapshot.data.docs[index]['img'],
                            title: snapshot.data.docs[index]['title'],
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
        const SizedBox(
          height: 50,
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: List.generate(
        //       5,
        //       (index) =>  DesignGovHealthCard(imgLink: ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
