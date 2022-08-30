import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';

import 'components/first_section.dart';
import 'components/second_section.dart';
import 'components/third_section.dart';

class HomeUpperContainer extends StatelessWidget {
  const HomeUpperContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF6C6FDB),
          borderRadius: BorderRadius.circular(20),
        ),
        height: getProportionateScreenHeight(350),
        // color: const Color(0xFF6C6FDB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FirstSection(),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            const SecondSection(),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            const ThirdSection(),
          ],
        ),
      ),
    );
  }
}
