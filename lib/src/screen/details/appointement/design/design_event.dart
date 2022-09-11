// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/progress_bar.dart';
import '../../../../video/model/data_store.dart';
import '../../../../video/model/meeting_lin.dart';
import '../../../../video/service/join_service.dart';
import '../../../../video/service/sdk_intializer.dart';

class DesignEvent extends StatefulWidget {
  final String name;
  final String expt;
  final String docImg;
  final String date;
  final String time;
  const DesignEvent({
    Key? key,
    required this.name,
    required this.expt,
    required this.docImg,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<DesignEvent> createState() => _DesignEventState();
}

class _DesignEventState extends State<DesignEvent> {
  late UserDataStore _dataStore;
  bool _isLoading = false;
  Future<bool> joinRoom() async {
    setState(() {
      _isLoading = true;
    });
    bool isJoinSuccessful = await JoinService.join(SDKIntializer.hmssdk);
    if (!isJoinSuccessful) {
      return false;
    }
    _dataStore = UserDataStore();
    _dataStore.startListen();
    setState(() {
      _isLoading = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(0),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              height: getProportionateScreenHeight(260),
              width: getProportionateScreenWidth(500),
              decoration: decoration(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14.0)),
                          child: CachedNetworkImage(
                            imageUrl: widget.docImg,
                            width: 100,
                            alignment: Alignment.topRight,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    circularProgress(),
                          ),
                        ),
                        // Image.network(
                        //   docImg,
                        //   width: 100,
                        // ),
                        SizedBox(
                          width: getProportionateScreenWidth(24),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name.length >= 15
                                  ? widget.name.substring(0, 15)
                                  : widget.name,
                              softWrap: true,
                              style: textStyle().copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.expt,
                              style: textStyle().copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: decoration(),
                      height: 40,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.calendarCheck,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(widget.date),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(50),
                          ),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.clock,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                "${widget.time.substring(0, 2)} : ${widget.time.substring(2)}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 14,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: onCancel,
                          child: Text(
                            'Cancel',
                            style: textStyle().copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(68),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF47CEFE),
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () async {
                              bool isJoined = await joinRoom();
                              if (isJoined) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ListenableProvider.value(
                                      value: _dataStore,
                                      child: const MeetingScreen(),
                                    ),
                                  ),
                                );
                              } else {
                                const SnackBar(content: Text("Error"));
                              }
                            },
                            child: const Text('Join'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onCancel() {}

void onJoinVideoConference() {}
