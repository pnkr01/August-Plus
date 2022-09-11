import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/constant/shimmer.dart';
import 'package:august_plus/utils/progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailGovScreen extends StatelessWidget {
  final String title;
  final String describe;
  final String imgLink;
  const DetailGovScreen({
    Key? key,
    required this.title,
    required this.describe,
    required this.imgLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Gov E-Health',
          style: textStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: decoration().copyWith(
                  color: const Color(0xFFFF9933),
                ),
                //height: 40,
                child: Center(
                  child: Text(
                    title,
                    style: textStyle(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 8.0,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(24.0),
                ),
                child: CachedNetworkImage(
                  placeholder: ((context, url) => const NewsCardSkelton()),
                  imageUrl: imgLink,
                  // progressIndicatorBuilder: (context, url, progress) =>
                  //     circularProgress(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 8.0,
              ),
              child: Container(
                decoration: decoration().copyWith(
                  color: const Color.fromRGBO(0, 0, 128, 0),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    describe,
                    style: textStyle().copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF000080),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: textStyle().copyWith(fontSize: 18.0),
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
