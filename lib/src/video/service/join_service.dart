import 'dart:convert';

import 'package:august_plus/utils/global.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:http/http.dart' as https;

class JoinService {
  static Future<bool> join(HMSSDK hmssdk) async {
    String roomId = '631ca39b4208780bf662c833';
    Uri endpoint = Uri.parse(
        'https://prod-in2.100ms.live/hmsapi/augustplus-augustplus.app.100ms.live/api/token');
    https.Response response = await https.post(endpoint, body: {
      'user_id': sharedPreferences.getString('name') ?? 'Patient',
      'room_id': roomId,
      'role': "host"
    });

    var body = json.decode(response.body);
    if (body == null || body['token'] == null) {
      return false;
    }
    HMSConfig config = HMSConfig(authToken: body['token'], userName: 'user');
    await hmssdk.join(config: config);
    return true;
  }
}
