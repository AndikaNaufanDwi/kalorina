import 'package:flutter/material.dart';
import 'package:projects_sehatin/utility/onBoardBottom.dart';
import 'package:projects_sehatin/utility/onBoardPage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    _pageController.jumpToPage(2);
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
                  if (_currentIndex < 2) _currentIndex++;
                });
              },
              onSkip: () {
                setState(() {
                  _currentIndex = 2;
                });
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
