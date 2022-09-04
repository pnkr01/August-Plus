import 'dart:async';

import 'package:august_plus/utils/global.dart';
import 'package:august_plus/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double toppading = 200;
  double bottomPadding = 10;
  bool mapToggle = false;
  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  checkPermission() {
    //Geolocator.getCurrentPosition();
    Future.delayed(const Duration(milliseconds: 55), () {
      setState(() {
        mapToggle = !mapToggle;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: mapToggle
            ? GoogleMap(
                // polylines: Set<Polyline>.of(polyline),
                //markers: Set<Marker>.of(markers.values),
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
                    sharedPreferences.getDouble("lat")!,
                    sharedPreferences.getDouble("long")!,
                  ),
                  zoom: 20.0,
                  // bearing: 90.0,
                  // tilt: 45.0,
                ),
              )
            : const Center(
                child: LoadingDialog(message: "Please Wait"),
              ));
  }
}
