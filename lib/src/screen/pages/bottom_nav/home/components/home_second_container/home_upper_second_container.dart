import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';
import 'components/doctor_card.dart';

class HomeUpperSecondContainer extends StatelessWidget {
  const HomeUpperSecondContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List doctorsImage = [
      'assets/doctors/one.webp',
      'assets/doctors/two.jpg',
      'assets/doctors/three.webp',
      'assets/doctors/four.jpg',
      'assets/doctors/six.jpg',
      'assets/doctors/seven.jpg',
      'assets/doctors/eight.jpg',
      'assets/doctors/nine.jpg',
    ];
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Doctor of the week',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  doctorsImage.length,
                  (index) {
                    return DoctorCard(
                      doctImage: doctorsImage[index],
                      width: getProportionateScreenHeight(100),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
