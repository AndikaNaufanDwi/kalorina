import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/Screen/login.dart';
import 'package:projects_sehatin/utility/signUpwidgets.dart';
import 'package:projects_sehatin/utility/widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  Future<void> _signUp() async {
    if (_passwordController.text != _repeatPasswordController.text) {
      _showDialog("Error", "Passwords tidak sama!");
      return;
    }

    var url = Uri.parse("http://127.0.0.1:5000/users");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nama": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      _showDialog("Success", "Sign up berhasil", success: true);
    } else {
      _showDialog("Error", "Sign up Gagal: ${response.body}");
    }
  }

  void _showDialog(String title, String message, {bool success = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

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
              customText("Maintain your calories and stay healthy!", fontSize: 15),
              SizedBox(height: 30),
              Column(
                children: [
                  BuildSignUpBox(
                    controller: _usernameController,
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Nama Pengguna",
                  ),
                  SizedBox(height: 10),
                  BuildSignUpBox(
                    controller: _emailController,
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Email",
                  ),
                  SizedBox(height: 10),
                  BuildSignUpBox(
                    controller: _passwordController,
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: "New Password",
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  BuildSignUpBox(
                    controller: _repeatPasswordController,
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: "Repeat Password",
                    isPassword: true,
                  ),
                ],
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: _signUp,
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
