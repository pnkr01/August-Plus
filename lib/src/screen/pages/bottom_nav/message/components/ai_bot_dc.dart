import 'dart:developer';

import 'package:august_plus/src/screen/pages/bottom_nav/message/components/ai_bot_header.dart';
import 'package:flutter/material.dart';

import '../../../../../size_configuration.dart';
import '../message_nav.dart';

class AIBotDecision extends StatelessWidget {
  const AIBotDecision({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('here');
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: const [
        Positioned.fill(
          child: MessageNav(),
        ),
        AiBotHeader(),
      ]),
    );
  }
}
