import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';

class DesignAmbulanceCard extends StatelessWidget {
  final String address;
  final String distance;
  final String name;
  const DesignAmbulanceCard({
    Key? key,
    required this.address,
    required this.distance,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xFF6C6FDB),
                borderRadius: BorderRadius.all(
                  Radius.circular(28.0),
                )),
                // child: ,
          ),
          const SizedBox(
            height: 28,
          ),
        ],
      ),
    );
  }
}
