import 'package:flutter/material.dart';

import '../../../../src/size_configuration.dart';
import 'profile_header.dart';
import 'profilebody.dart';

class Profile extends StatelessWidget {
  final String phone;
  const Profile({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const ProfileHeader(),
          BuildProfileBody(phoneNumber: phone),
        ],
      ),
    );
  }
}
