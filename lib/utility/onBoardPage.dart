import 'package:flutter/material.dart';

class onBoardPage extends StatelessWidget {
  const onBoardPage({
    super.key,
    required this.imagePath,
    // required this.text
  });

  final String imagePath;
  // final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo_landing.png', height: 100, width: 100),
        SizedBox(height: 0),
        Image.asset(imagePath, width: 230, height: 230),
        // const SizedBox(height: 20),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30),
        //   child: Text(
        //     text,
        //     style: const TextStyle(
        //       color: Colors.white,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
      ],
    );
  }
}
