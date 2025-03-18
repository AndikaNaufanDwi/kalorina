import 'package:flutter/material.dart';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/Screen/signup.dart';
import 'package:projects_sehatin/utility/loginWidgets.dart';
import 'package:projects_sehatin/utility/widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E9D9D),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText("Login", fontSize: 30, fontWeight: FontWeight.bold),

            SizedBox(height: 8),
            customText(
              "Maintain your calories and stay healthy!",
              fontSize: 15,
            ),
            SizedBox(height: 30),
            // Email Field
            Column(
              children: [
                BuildLoginBox(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                ),
                SizedBox(height: 10),
                BuildLoginBox(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: "Password",
                  isPassword: true,
                ),
              ],
            ),
            SizedBox(height: 10),
            // Remember Me Checkbox and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 2),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                            color:
                                isChecked ? Colors.white : Colors.transparent,
                          ),
                          child:
                              isChecked
                                  ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 16,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    customText("Ingat saya"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: customText(
                    "Lupa Password?",
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: customText(
                "Login",
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E5172),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Divider with "atau"
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: customText("atau"),
                  ),
                  Expanded(child: Divider(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Google Login Button
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/google_icon.png',
                width: 22,
                height: 22,
              ),
              label: customText("Google", color: Color(0xFF000000)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 98, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Sign Up Text
            CustomTextSpan(
              text: "Belum punya akun? ",
              highlightedText: "Sign Up",
              targetPage: SignUpScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
