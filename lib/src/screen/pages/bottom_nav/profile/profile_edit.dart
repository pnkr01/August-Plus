import 'dart:developer';

import 'package:august_plus/src/screen/pages/bottom_nav/profile/user.dart';
import 'package:august_plus/src/screen/pages/bottom_nav/profile/user_pref.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/global.dart';
import '../../../../app.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class Profile1 extends StatefulWidget {
  const Profile1({Key? key}) : super(key: key);

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  final List<Color> colors = [
    const Color(0xffF19821),
    const Color(0xffb457d4),
    const Color(0xff0454fc),
    const Color(0xff201b6e),
    const Color(0xff436073),
    const Color.fromARGB(255, 33, 171, 26),
    const Color.fromARGB(255, 145, 164, 37),
    const Color(0xFF45d9c5),
  ];

  List title = [
    'Name',
    'Email',
    'Phone',
    'Signed In As',
    'Booked Doctors',
    'Booked Ambulance',
    'Created At',
  ];

  @override
  Widget build(BuildContext context) {
    final user = UserPrefrence.myUser;
    log(user.name);
    List titleAns = [
      user.name,
      user.email,
      user.phone,
      user.signedInAs,
      user.bookedDoctorsSoFar,
      user.bookedAmbulanceSoFar,
      user.createdAt.substring(0, 10),
    ];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 128, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/p4.png"),
                    radius: 70,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              buildAbout(user,title, titleAns),
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the About Me Section
  Widget buildAbout(User user, var title, var ans) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Your Name',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          const SizedBox(height: 8),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.name,
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       // const Icon(
          //       //   Icons.keyboard_arrow_right,
          //       //   color: Colors.grey,
          //       //   size: 40.0,
          //       // ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 5),
          // const Text(
          //   'Your Email',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.email,
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 5),
          GridView.count(
            addRepaintBoundaries: true,
            // crossAxisSpacing: 2,
            // padding: EdgeInsets.only(
            //   right: 10
            // ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width / (3 * 100)),
            children: List.generate(
              7,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      shape: BoxShape.rectangle,
                      color: colors[index],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        16.0,
                        0.0,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              title[index],
                              style: GoogleFonts.inder(
                                color: Colors.white,
                                fontSize: 18.0,
                              )
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                            index == 4 ? user.bookedDoctorsSoFar.toString() : index == 5 ? user.bookedAmbulanceSoFar.toString()  : ans[index],
                                style: GoogleFonts.inder(
                                  color: Colors.white,
                                )
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // const Text(
          //   'Your Phone',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.phone,
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const Text(
          //   'Account Created At',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.createdAt.substring(0, 10),
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const Text(
          //   'Signed In As',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.signedInAs,
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const Text(
          //   'Booked Ambulance So Far',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.bookedAmbulanceSoFar.toString(),
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const Text(
          //   'Booked Appointements So Far',
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.grey,
          //   ),
          // ),
          // const SizedBox(height: 1),
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          //           child: Align(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               user.bookedAmbulanceSoFar.toString(),
          //               style: const TextStyle(
          //                 fontSize: 16,
          //                 height: 1.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color(0xFF6C6FDB),
                ),
                onPressed: () async {
                  sharedPreferences.clear();
                  await firebaseAuth.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HandleOnboarding()),
                          (route) => false));
                },
                child: const Text("Logout"),
              ),
            ),
          ),
        ],
      );
}
