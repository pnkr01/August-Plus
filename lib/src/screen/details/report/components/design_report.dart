import 'package:flutter/material.dart';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';

class ReportDesign extends StatelessWidget {
  // final String medicine;
  // final String precaution;
  // final String problem;
  // final String type;
  final String docName;
  final Color color;
  const ReportDesign({
    Key? key,
    required this.docName,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: getProportionateScreenHeight(180),
        width: double.infinity,
        decoration: decoration().copyWith(
          color: color,
        ),
        child: Center(
          child: Flexible(
            child: Text(
              'Report Available by $docName',
              style: textStyle().copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
