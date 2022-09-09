import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/screen/details/appointement/design/design_event.dart';
import 'package:august_plus/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constant/shimmer.dart';

class SheduleSection extends StatefulWidget {
  const SheduleSection({Key? key}) : super(key: key);

  @override
  State<SheduleSection> createState() => _SheduleSectionState();
}

class _SheduleSectionState extends State<SheduleSection>
    with SingleTickerProviderStateMixin, RestorationMixin {
  Stream stream = FirebaseFirestore.instance
      .collection('phone')
      .doc(sharedPreferences.getString('phone'))
      .collection('apoint')
      .snapshots();
  // String? selectedItem = sharedPreferences!.getString('dham') ?? 'Puri';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      "Upcoming",
      "Complete",
      "Cancel",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Shedule',
          style: textStyle(),
        ),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    color: kPrimaryColor,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.deepPurple,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(99.0),
                    ),
                  ),
                  labelColor: Colors.white,
                  labelStyle: textStyle().copyWith(
                    fontSize: 14.0,
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    for (final tab in tabs)
                      Tab(
                        text: tab,
                      ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    upComingEvent(),
                     Center(
                      child: Text('No Data',style: textStyle().copyWith(color: Colors.black),),
                    ),
                     Center(
                      child: Text('No Data',style: textStyle().copyWith(color: Colors.black),),
                    ),
                    // Text('data')
                    // UpComingEvent(),
                    // CompletedEvent(),
                    // CancelledEvent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget upComingEvent() {
  Stream stream = FirebaseFirestore.instance
      .collection('phone')
      .doc(sharedPreferences.getString('phone'))
      .collection('apoint')
      .snapshots();
  return StreamBuilder(
    stream: stream,
    builder: (context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const NewsCardSkelton();
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(
                snapshot.data.docs.length,
                (index) {
                  return DesignEvent(
                    name: snapshot.data.docs[index]['doctName'],
                    expt: snapshot.data.docs[index]['docExpt'],
                    docImg: snapshot.data.docs[index]['img'],
                    date: snapshot.data.docs[index]['date'],
                    time: snapshot.data.docs[index]['time'],
                  );
                },
              ),
            ],
          ),
        );
      }
    },
  );
}
// Widget CompletedEvent {
// }
// Widget CancelledEvent {
// }


