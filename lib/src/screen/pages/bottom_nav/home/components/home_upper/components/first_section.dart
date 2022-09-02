import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi ${sharedPreferences.getString('name')}',
                style: textStyle(),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text(
                'How do you feel today ?',
                style: textStyle(),
              ),
            ],
          ),
          Container(
            height: getProportionateScreenHeight(65),
            width: getProportionateScreenHeight(65),
            decoration: const BoxDecoration(
              color: Color(0xFF8E8BE1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.solidBell,
                color: Colors.white,
                size: getProportionateScreenHeight(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
