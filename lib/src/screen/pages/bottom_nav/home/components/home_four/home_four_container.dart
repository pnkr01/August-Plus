import 'package:flutter/material.dart';

import 'components/govt_cards.dart';

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => const DesignGovHealthCard(),
            ),
          ),
        )
      ],
    );
  }
}
