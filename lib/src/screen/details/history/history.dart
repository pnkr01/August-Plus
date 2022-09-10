import 'package:august_plus/src/constant/constant.dart';
import 'package:flutter/material.dart';

class HistoryScetion extends StatelessWidget {
  const HistoryScetion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: textStyle().copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
