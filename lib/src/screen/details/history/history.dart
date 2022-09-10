import 'package:august_plus/src/constant/constant.dart';
import 'package:flutter/material.dart';

class HistoryScetion extends StatelessWidget {
  const HistoryScetion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'History',
          style: textStyle().copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          'No Data',
          style: textStyle().copyWith(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
