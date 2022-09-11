import 'package:august_plus/src/constant/constant.dart';
import 'package:flutter/material.dart';

class NotificaationSCreen extends StatelessWidget {
  const NotificaationSCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notification',
          style: textStyle(),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Text(
          'No Notification',
          style: textStyle().copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
