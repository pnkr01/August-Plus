import 'package:flutter/material.dart';

import '../src/constant/constant.dart';

circularProgress() {
  return Container(
    padding: const EdgeInsets.only(top: 12.0),
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      backgroundColor: kPrimaryColor,
      valueColor: AlwaysStoppedAnimation(kPrimaryColor),
    ),
  );
}