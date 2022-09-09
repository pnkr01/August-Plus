import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:august_plus/src/size_configuration.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
    //required this.doctImage,
    this.aspectRetio = 1.02,
    required this.doctImage,
    required this.name,
    required this.expertise,
    required this.width,
  }) : super(key: key);

  final double width, aspectRetio;
  final String doctImage;
  final String name;
  final String expertise;

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
                      child: Image.network(
                        doctImage,
                        alignment: Alignment.topRight,
                        fit: BoxFit.fill,
                      )),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(name),
                const SizedBox(
                  height: 8,
                ),
                Text(expertise),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const BuildBottonWithContainer(
                  colorText: Color(0xFF7096E0),
                  colorIcon: Color(0xFFE883DE),
                  text: 'Book',
                  iconData: FontAwesomeIcons.solidMessage,
                ),
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

class BuildBottonWithContainer extends StatelessWidget {
  final Color colorText;
  final Color colorIcon;
  final String text;
  final IconData iconData;
  const BuildBottonWithContainer({
    Key? key,
    required this.colorText,
    required this.colorIcon,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorText,
            borderRadius: BorderRadius.circular(14),
          ),
          height: 50,
          width: 100,
          child: TextButton(
            onPressed: () {},
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 28,
        ),
        Container(
          decoration: BoxDecoration(
            color: colorIcon,
            borderRadius: BorderRadius.circular(14),
          ),
          height: 50,
          width: 50,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
