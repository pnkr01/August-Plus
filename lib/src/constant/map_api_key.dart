import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/global.dart';

class MapKey {
  static readyApiKey() async {
    await FirebaseFirestore.instance
        .collection('api')
        .doc('1LXqELFRwnQa7hnjwstu')
        .get()
        .then((snap) {
      String key = snap.data()!["api"];
      sharedPreferences.setString('key', key);
    });
  }
}
