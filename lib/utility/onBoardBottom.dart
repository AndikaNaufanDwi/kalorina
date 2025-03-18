import 'package:flutter/material.dart';
import 'package:projects_sehatin/Screen/login.dart';
import 'package:projects_sehatin/Screen/signup.dart';
import 'package:projects_sehatin/utility/widget.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final List<String> textList;
  final List<String> textList2;

  const OnboardingNavigation({
    Key? key,
    required this.currentIndex,
    required this.onNext,
    required this.onSkip,
    required this.textList,
    required this.textList2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 10 : 8,
                      height: currentIndex == index ? 10 : 8,
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index
                                ? Color(0xFF2D9D9E)
                                : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(
                  textList[currentIndex],
                  fontSize: 20,
                  color: Color(0xFF0B0A0A),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2),
                customText(
                  textList2[currentIndex],
                  fontSize: 11,
                  color: Color(0xFF595F67),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: customText("Login", fontWeight: FontWeight.bold),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E9D9D),
                    foregroundColor: Color(0xFFFFFFFF),
                    padding: EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: customText(
                    "Sign Up",
                    color: Color(0xFF1E5172),
                    fontWeight: FontWeight.bold,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    foregroundColor: Color(0xFF2E9D9D),
                    padding: EdgeInsets.symmetric(horizontal: 110, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Color(0xFF1E5172), width: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
