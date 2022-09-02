import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:august_plus/src/size_configuration.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List iconData = [
      FontAwesomeIcons.appStoreIos,
      FontAwesomeIcons.solidHospital,
      FontAwesomeIcons.clockRotateLeft,
      FontAwesomeIcons.fileMedical
    ];
    List iconText = [
      'Appointment',
      '   Hospital',
      '   History',
      '   Reports',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        iconData.length,
        (index) => CreateContainerWithIcon(
          iconData: iconData[index],
          iconText: iconText[index],
        ),
      ),
    );
  }
}

class CreateContainerWithIcon extends StatelessWidget {
  final IconData iconData;
  final String iconText;
  const CreateContainerWithIcon({
    Key? key,
    required this.iconData,
    required this.iconText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: getProportionateScreenWidth(65),
          width: getProportionateScreenWidth(65),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(getProportionateScreenWidth(8)),
            ),
            color: const Color(0xFF8E8BE1),
          ),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Text(
          iconText,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
