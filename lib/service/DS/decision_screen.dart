import 'package:august_plus/src/constant/constant.dart';
import 'package:august_plus/src/size_configuration.dart';
import 'package:august_plus/utils/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DecisionScreen extends StatefulWidget {
  const DecisionScreen({Key? key}) : super(key: key);

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  List<String> role = [
    'Patient',
    'Doctor',
  ];
  String roleItem = 'Patient';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(100),
            ),
            Image.asset('assets/images/nn.png'),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select your role',
                style: textStyle().copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(14),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 0.80,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    items: role
                        .map(
                          (role) => DropdownMenuItem<String>(
                            value: role,
                            child: Text(
                              role,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (item) => setState(() {
                      roleItem = item as String;
                      sharedPreferences.setString('role', roleItem);
                      if (kDebugMode) {
                        print(roleItem);
                      }
                    }),
                    value: roleItem,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(14),
            ),
            SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/login',
                  );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
