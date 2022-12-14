import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashContent extends StatelessWidget {
  final String? image;
  final String? text;
  final Color? color;
  const SplashContent({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image ?? 'assets/images/five.jpg',
              fit: BoxFit.cover,
              height: size.height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                text ?? 'Should Provide Text Error',
                style: GoogleFonts.fredokaOne(
                  color: const Color.fromARGB(255, 133, 70, 119),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
