import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';

class DesignEvent extends StatelessWidget {
  final String name;
  final String expt;
  final String docImg;
  final String date;
  final String time;
  const DesignEvent({
    Key? key,
    required this.name,
    required this.expt,
    required this.docImg,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(80),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            height: getProportionateScreenHeight(260),
            width: double.infinity,
            decoration: decoration(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    top: 20.0,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        docImg,
                        width: 100,
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          Text(name),
                          Text(expt),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    decoration: decoration(),
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.calendarCheck,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(date),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(50),
                        ),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              date,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 14,
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: onCancel,
                        child: Text(
                          'Cancel',
                          style: textStyle().copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(110),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF47CEFE),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: onreshedule,
                        child: Text(
                          'Reshedule',
                          style: textStyle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void onCancel() {}

void onreshedule() {}
