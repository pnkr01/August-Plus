import 'package:august_plus/src/app.dart';
import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/screen/pages/Doctor/components/fill_medical_report.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEFF4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notification_add_outlined,
                        size: 28,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          sharedPreferences.getString('img') ??
                              'https://img.freepik.com/premium-photo/medical-concept-asian-beautiful-female-doctor-white-coat-with-glasses-waist-high-medical-student-female-hospital-worker-looks-into-camera-smiles-studio-blue-background_185696-615.jpg?w=740',
                          width: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${sharedPreferences.getString('name')!}',
                        style: textStyle().copyWith(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        'How is your mood Today ?',
                        style: textStyle().copyWith(
                          color: Colors.grey,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20.0,
                    right: 10,
                  ),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: decoration(),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(28),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10.0,
                  ),
                  child: Text(
                    'Up Coming Shedule',
                    style: textStyle().copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),

                //TODOS: Stream Builder area on demand hor scroll..
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
                      .doc(
                          sharedPreferences.getString('phone')!.substring(0, 1))
                      .collection('pat')
                      .snapshots(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.data.docs.length == 0) {
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 10,
                            top: 10.0,
                          ),
                          child: Container(
                            height: 100,
                            width: 400,
                            decoration: decoration(),
                            child: const Center(
                              child: Text('no booking found'),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              snapshot.data.docs.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => FillMedical(
                                                name: snapshot.data.docs[index]
                                                    ['patname'],
                                                number: snapshot
                                                    .data.docs[index]['patnum'],
                                              )))),
                                  child: createContainer(
                                    snapshot.data.docs[index]['date'],
                                    snapshot.data.docs[index]['time'],
                                    snapshot.data.docs[index]['patname'],
                                    snapshot.data.docs[index]['patnum'],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Your Recent Contribution',
                    style: textStyle().copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 10,
                      top: 20.0,
                    ),
                    child: Container(
                      height: 100,
                      width: 400,
                      decoration: decoration(),
                      child: const Center(
                        child: Text('no booking found'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 10.0,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        sharedPreferences.clear();
                        await firebaseAuth.signOut().then((value) =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const HandleOnboarding())),
                                (route) => false));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Logout'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildIndicator(int len, int index) => AnimatedSmoothIndicator(
  //       activeIndex: index,
  //       count: len,
  //       effect: CustomizableEffect(
  //         dotDecoration: DotDecoration(
  //           width: 24,
  //           height: 12,
  //           color: Colors.green,
  //           borderRadius: BorderRadius.circular(16),
  //           verticalOffset: 0,
  //         ),
  //         activeDotDecoration: DotDecoration(
  //           width: 32,
  //           height: 12,
  //           color: Colors.indigo,
  //           rotationAngle: 180,
  //           verticalOffset: -10,
  //           borderRadius: BorderRadius.circular(24),
  //         ),
  //         inActiveColorOverride: (i) => Colors.red,
  //       ),
  //     );

  Widget createContainer(
      String date, String time, String patname, String patnum) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        height: 200,
        width: getProportionateScreenWidth(330),
        decoration: decoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 40),
                  child: Text(
                    date,
                    style: textStyle().copyWith(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 40),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: decoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset('assets/images/p3.png'),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
              ),
              child: Container(
                height: 150,
                width: 150,
                decoration: decoration(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        patname,
                        style: textStyle()
                            .copyWith(color: Colors.black, fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.phone),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            patnum,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.clock),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("$time HR"),
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          onPressed: () {},
                          child: const Text('Connect'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
