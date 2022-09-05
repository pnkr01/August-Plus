import 'package:august_plus/src/screen/pages/bottom_nav/profile/user.dart';

import '../../../../../utils/global.dart';

class UserPrefrence {
  static final myUser = User(
    bookedDoctorsSoFar: sharedPreferences.getInt('nD') ?? 0,
    bookedAmbulanceSoFar: sharedPreferences.getInt('nA') ?? 0,
    signedInAs: sharedPreferences.getString('sI') ?? 'Patient',
    name: sharedPreferences.getString('name') ?? "",
    email: sharedPreferences.getString('email') ?? "no",
    //isDarkMode: false,
    phone: sharedPreferences.getString("phone") ?? "",
    createdAt: DateTime.now().toIso8601String(),
  );
}
