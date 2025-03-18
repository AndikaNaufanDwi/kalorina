import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Left splash image
          Positioned(
            left: -60,
            top: 65,
            child: Transform.rotate(
              angle: 0,
              child: Image.asset(
                "assets/left_splash.png",
                width: 280,
                height: 280,
              ),
            ),
          ),

          // Right splash image
          Positioned(
            right: -63,
            bottom: 30,
            child: Transform.rotate(
              angle: 0,
              child: Image.asset(
                "assets/right_splash.png",
                width: 280,
                height: 280,
              ),
            ),
          ),

          // Center text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo_awal.png', height: 240, width: 240),
                // RichText(
                //   text: TextSpan(
                //     style: GoogleFonts.poppins(
                //       fontSize: 50,
                //       fontWeight: FontWeight.bold,
                //       color: Color(0xFF2E9D9D),
                //     ),
                //     children: [
                //       const TextSpan(text: 'Kalori'),
                //       TextSpan(
                //         text: 'na',
                //         style: TextStyle(color: Color(0xFF1E5172)),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 8),
                // SizedBox(
                //   width: 220, // Total width
                //   height: 4,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 5,
                //         child: Container(color: Colors.blueGrey.shade800),
                //       ),
                //       Flexible(
                //         flex: 2,
                //         child: Container(color: Colors.teal.shade500),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
