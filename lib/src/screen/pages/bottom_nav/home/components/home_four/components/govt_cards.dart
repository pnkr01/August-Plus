import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';

class DesignGovHealthCard extends StatelessWidget {
  const DesignGovHealthCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 280,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFFFFDFF),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 234, 230, 230), //New
                blurRadius: 10.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 140,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.asset(
                      'assets/images/five.jpg',
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                const Text(
                  'Things that should be done during quarnatine',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //TODOS : SEND TO DETAILSCREEN WITH DATA
                    },
                    child: const Text('Read More'),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenHeight(20),
        ),
      ],
    );
  }
}
