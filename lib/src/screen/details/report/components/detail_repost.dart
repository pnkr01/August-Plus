import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:flutter/material.dart';

class DetailReport extends StatelessWidget {
  final String medicine;
  final String precaution;
  final String problem;
  final String type;
  const DetailReport({
    Key? key,
    required this.medicine,
    required this.precaution,
    required this.problem,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Deatil Report',
          style: textStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 100,
                decoration: decoration().copyWith(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(0.0)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/a.png'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Flexible(
                      child: Text(
                        'You are getting closer to healthy life',
                        style: textStyle()
                            .copyWith(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //type
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: decoration().copyWith(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Flexible(
                      child: Text(
                        "Type of Problem :  $type",
                        style: textStyle().copyWith(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  )),
            ),
            //problem
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: decoration().copyWith(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Flexible(
                      child: Text(
                        " Problem In Breif : $problem",
                        style: textStyle().copyWith(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  )),
            ),
            //medicine
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: decoration().copyWith(
                      color: const Color.fromARGB(255, 180, 145, 41),
                      borderRadius: BorderRadius.circular(0.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Flexible(
                      child: Text(
                        "Medicine : $medicine",
                        style: textStyle().copyWith(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  )),
            ),
            //presc
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: decoration().copyWith(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(0.0)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Flexible(
                    child: Text(
                      "Precaution : $precaution",
                      style: textStyle().copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(4),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: textStyle(),
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
