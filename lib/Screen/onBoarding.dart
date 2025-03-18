import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projects_sehatin/utility/onBoardBottom.dart';
import 'package:projects_sehatin/utility/onBoardPage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < 2) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Loop back to first page
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E9D9D),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  onBoardPage(imagePath: "assets/dash_1.png"),
                  onBoardPage(imagePath: "assets/dash_2.png"),
                  onBoardPage(imagePath: "assets/dash_3.png"),
                ],
              ),
            ),
            OnboardingNavigation(
              currentIndex: _currentIndex,
              onNext: () {
                setState(() {
                  if (_currentIndex < 2) {
                    _currentIndex++;
                  } else {
                    _currentIndex = 0; // Loop back to first page
                  }
                });
                _pageController.animateToPage(
                  _currentIndex,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              onSkip: () {
                setState(() {
                  _currentIndex = 2;
                });
                _pageController.jumpToPage(2);
              },
              textList: ["Jaga Kalori Harianmu", "Bebas Insomnia", "HaloGizi"],
              textList2: [
                "Gak usah takut kekurangan kalori harianmu! Ayo cek kebutuhan kalorimu hari ini!",
                "Putar playlistmu, dengarkan, rilekskan diri, dan tidur tepat waktu 😴",
                "Konsultasi dengan ahli gizi agar nutrisimu seimbang dan berat badan tetap ideal",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
