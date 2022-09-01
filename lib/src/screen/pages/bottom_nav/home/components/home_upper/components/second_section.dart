import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondSection extends StatelessWidget {
  const SecondSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "      Search doctors or clinic..",
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 25,
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFF918BE0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF918BE0),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF918BE0),
              width: 1.0,
            ),
          ),
        ),
        cursorWidth: 2,
      ),
    );
  }
}
