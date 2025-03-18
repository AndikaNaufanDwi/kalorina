import 'package:flutter/material.dart';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/Screen/login.dart';
import 'package:projects_sehatin/utility/signUpwidgets.dart';
import 'package:projects_sehatin/utility/widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E9D9D),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText("Sign Up", fontSize: 30, fontWeight: FontWeight.bold),

              SizedBox(height: 8),
              customText(
                "Maintain your calories and stay healthy!",
                fontSize: 15,
              ),
              SizedBox(height: 30),
              // Email Field
              Column(
                children: [
                  BuildSignUpBox(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Email",
                  ),
                  SizedBox(height: 10),
                  BuildSignUpBox(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: "New Password",
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  BuildSignUpBox(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: "Repeat Password",
                    isPassword: true,
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                  "Sign Up",
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
              CustomTextSpan(
                text: "Sudah punya akun? ",
                highlightedText: "Login",
                targetPage: LoginScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
