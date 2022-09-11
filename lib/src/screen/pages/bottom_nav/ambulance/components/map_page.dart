// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:august_plus/src/screen/pages/bottom_nav/ambulance/model/nearest_ambulance.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/errordialog.dart';
import 'package:august_plus/utils/global.dart';
import 'package:august_plus/utils/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as https;

import 'booked_ambulance.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late List<LatLng> routeCoords = [];
  final Set<Polyline> polyline = {};
  GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(
    apiKey: sharedPreferences.getString('key') ??
        'AIzaSyC0XggvP89ZOcb5DiaQirStM6eF5AYLPEM',
  );
  List<NearByAmbulanceResult> nearevstationresult = [];
  double toppading = 200;
  double bottomPadding = 10;
  bool mapToggle = false;
  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  checkPermission() {
    Geolocator.getCurrentPosition();
    Future.delayed(const Duration(milliseconds: 55), () {})
        .then((value) => populateClients())
        .then(
          (value) => setState(() {
            mapToggle = !mapToggle;
          }),
        );
  }

  getSomepoints(double desLat, double desLong) async {
    routeCoords = (await googleMapPolyline.getCoordinatesWithLocation(
      // haredPreferences!.getDouble("lat")!,
      //             sharedPreferences!.getDouble("long")!,
      origin: LatLng(sharedPreferences.getDouble("lat")!,
          sharedPreferences.getDouble("long")!),
      destination: LatLng(desLat, desLong),
      mode: RouteMode.driving,
    ))!;
    // 22.7855319, 86.2833178,
    setState(
      () {
        polyline.add(
          Polyline(
            polylineId: const PolylineId('route1'),
            visible: true,
            points: routeCoords,
            width: 5,
            color: const Color.fromARGB(255, 243, 142, 33),
            startCap: Cap.roundCap,
            endCap: Cap.buttCap,
          ),
        );
      },
    );
    // print(routeCoords);
  }

  populateClients() async {
    await getNearby(sharedPreferences.getDouble("long")!,
        sharedPreferences.getDouble("lat")!);
  }

  Future<List<NearByAmbulanceResult>> getNearby(
      double longitude, double latitude) async {
    var response = await https.get(
      Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=30000&type=ambulance&keyword=ambulance&key=${sharedPreferences.getString('key')}",
      ),
    );
    var values = jsonDecode(response.body);
    final List result = values['results'];

    if (values["status"] == "OK") {
      // ignore: avoid_print
      print("Ok response");
      for (Map i in result) {
        nearevstationresult.add(NearByAmbulanceResult.fromJson(i));
      }
      showMarker();
      return nearevstationresult;
    } else {
      // ignore: avoid_print
      print(
          "Oye! Hero Map Key Change Karde thora 2 jagah toh mein places show kardun..");
      log("Kya gunda banega tu?");
      return nearevstationresult;
    }
  }

  //final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
      toppading = 600;
    });
  }

  showMarker() {
    for (int i = 0; i < nearevstationresult.length; i++) {
      initMarkerr(
        nearevstationresult[i].geometry!.location!.lat,
        nearevstationresult[i].geometry!.location!.lng,
        i.toString(),
        nearevstationresult[i].name,
        nearevstationresult[i].vicinity,
      );
    }
  }

  void initMarkerr(
      double? lat, double? long, specifyId, String? name, String? address) {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat ?? 0, long ?? 0),
      infoWindow: InfoWindow(
        title: name ?? "Name will be upated",
        snippet: address ?? "No address found",
      ),
      onTap: () {
        //TODOS: 1. SHOW ONE BOTTOM SHEET CONTAINER CONTAINIG IMAGE,DURATION DISTANCE, ADDRESS. TWO BUTTON CANCEL, START NAVIGATION.
        // print(specify['lat']);
        // print(specify['long']);

        var distance = Geolocator.distanceBetween(
          lat!,
          long!,
          sharedPreferences.getDouble("lat")!,
          sharedPreferences.getDouble("long")!,
        );

        //TODOS : THINGS TO SEND TO MARKER DESIGN.
        //TODOS : Fetch this details before sending to marker design.
        //TODOS : 1. NAME, ADDRESS , OPEN/CLOSED STATUS, DISTANCE, TIMMING , NUMBER
        //TODOS : 2. TYPES OF CHARGER
        //TODOS : 3. TWO BUTTONS CALLBACK --> CANCEL & NAVIGATION
        //TODOS : 4. MORE CAN BE SEND AS PER YOU WANT..
        //TODOS : 4. MARKER DESIGN WILL BUILD THAT FOR US.
        showModalBottomSheet(
            backgroundColor: Colors.white,
            enableDrag: true,
            isDismissible: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            )),
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.4,
                child: markerrDesign(
                  stationname: name ?? "No Name Found",
                  stationaddress: address ?? "No Address Found",
                  distance: distance / 1000,
                  lat: lat,
                  long: long,
                  time: (distance / 1000).toString().substring(0, 4),
                ),
              );
            });
      },
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapToggle
          ? GoogleMap(
              polylines: Set<Polyline>.of(polyline),
              markers: Set<Marker>.of(markers.values),
              mapType: MapType.normal,
              padding: EdgeInsets.only(
                top: toppading,
                bottom: bottomPadding,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: false,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  // 40.6782, -73.9442
                  // 22.7855319, 86.2833178,
                  sharedPreferences.getDouble("lat") ?? 0,
                  sharedPreferences.getDouble("long") ?? 0,
                ),
                zoom: 14.0,
                // bearing: 90.0,
                // tilt: 45.0,
              ),
            )
          : const Center(
              child: LoadingDialog(message: "Please Wait"),
            ),
    );
  }

  markerrDesign({
    String? stationname,
    String? stationaddress,
    double? distance,
    double? lat,
    double? long,
    String? time,
  }) {
    @override
        //Widget build(BuildContext context) {
        final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.width * 0.025,
            ),
            Divider(
              thickness: 3,
              color: Colors.grey.shade400,
              indent: size.width * 0.4,
              endIndent: size.width * 0.4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    stationname!,
                    //"Tata Steel Ambagan Parking Jubliee Park gate Jamshedpur Charging Station",
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.09,
                ),
                TextButton(
                  onPressed: () {},
                  child: Image.asset(
                    "assets/images/aa.png",
                    height: 30,
                  ),
                ),
              ],
            ),
            Text(
              stationaddress!,
              // "Ambagan, Sakchi, Jamshedpur",
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Open",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  height: 25,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                      child: Text(
                    'Will reach in $time min',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.blue,
                      size: 15,
                    ),
                    Text(
                      "${distance.toString().substring(0, 4)} km",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.15,
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidClock,
                      color: Colors.blue,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "12:00 am - 11:59 pm",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            const Center(
              child: Text(
                "Available Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(elevation: 0, primary: Colors.red),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: ((context) {
                    bookAmbulance(
                        context, distance, stationname, stationaddress);
                    return const LoadingDialog(message: "Please wait");
                  }),
                );

                const ErrorDialog(message: "Booked Sucessfully");
              },
              child: const SizedBox(
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Book",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: "VarelaRound",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(elevation: 0, primary: Colors.red),
              onPressed: () async {
                getSomepoints(lat!, long!);
                Navigator.pop(context);
              },
              child: const SizedBox(
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Navigation",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: "VarelaRound",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(elevation: 0, primary: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const SizedBox(
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: "VarelaRound",
                      fontWeight: FontWeight.bold,
                    ),
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

bookAmbulance(
    BuildContext context, double? distance, String name, String address) {
  FirebaseFirestore.instance
      .collection('phone')
      .doc(sharedPreferences.getString('phone'))
      .collection('ambulance')
      .doc()
      .set({
    'distance': distance.toString().substring(0, 4),
    'address': address,
    'name': name,
  }).then((value) {
    Navigator.pop(context);
    Navigator.pop(context);
  }).then((value) {
    showSnackBar(
      context,
      'Booked Sucessfully',
      Colors.green,
    );
    sharedPreferences.setInt(
        'nA',
        sharedPreferences.getInt('nA') == 0 ||
                sharedPreferences.getInt('nA') == null
            ? 1
            : sharedPreferences.getInt('nA')! + 1);
  }).then((value) => showModalBottomSheet(
          backgroundColor: Colors.green,
          enableDrag: true,
          isDismissible: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          )),
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6C6FDB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                height: 30,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF918BE0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookedAmbulancePage(),
                          ),
                        );
                      },
                      child: const Text('Booked Sucessfully'),
                    )
                  ],
                ),
              ),
            );
          }));
}
