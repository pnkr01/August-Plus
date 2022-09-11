import 'package:august_plus/utils/global.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

import 'components/message_screen.dart';

class MessageNav extends StatefulWidget {
  const MessageNav({Key? key}) : super(key: key);

  @override
  State<MessageNav> createState() => _MessageNavState();
}

class _MessageNavState extends State<MessageNav> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Mental Health',
      //     style: textStyle(),
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: MessageScreen(messages: messages),
          ),
          Container(
            color: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(controller.text);
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage(String msg) async {
    if (msg.isEmpty) {
      showSnackBar(context, 'Message is Empty', Colors.red);
    } else {
      setState(() {
        addMessage(
            Message(
                text: DialogText(
              text: [msg],
            )),
            true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: msg)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }
}
