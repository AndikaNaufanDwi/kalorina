import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/Screen/signup.dart';
import 'package:projects_sehatin/utility/loginWidgets.dart';
import 'package:projects_sehatin/utility/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  Future<void> saveAccessToken(String accessToken) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      print("Access token berhasil disimpan!");
    } catch (e) {
      print("Gagal menyimpan access token: $e");
    }
  }

  Future<void> saveID(int idnya) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', idnya);
      print("ID berhasil disimpan!");
    } catch (e) {
      print("Gagal menyimpan access token: $e");
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showDialog("Error", "Email dan Password harus diisi!");
      return;
    }

    final url = Uri.parse("https://6cc5-210-210-144-170.ngrok-free.app/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = jsonDecode(response.body);

        if (responseData != null && responseData['access_token'] != null) {
          print(responseData);
          String accessToken = responseData['access_token'];
          int id = responseData['id'];
          print(accessToken);
          print(id);
          // // Simpan access token ke SharedPreferences
          await saveID(id);
          await saveAccessToken(accessToken);
          // Pindah ke halaman home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(i: 0)),
          );
        } else {
          _showDialog("Login Gagal", "Token tidak ditemukan dalam respons.");
        }
      } else {
        _showDialog(
          "Login Gagal",
          responseData['message'] ?? "Email atau password salah.",
        );
      }
    } catch (e) {
      _showDialog("Error", "Terjadi kesalahan. Coba lagi nanti.");
    }
  }

  void _showDialog(String title, String message, {bool success = false}) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(i: 0)),
                    );
                  }
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

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

            Column(
              children: [
                BuildLoginBox(
                  controller: _emailController,
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Email",
                ),
                SizedBox(height: 10),
                BuildLoginBox(
                  controller: _passwordController,
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: "Password",
                  isPassword: true,
                ),
              ],
            ),

            SizedBox(height: 10),
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
            ElevatedButton(
              onPressed: _login,
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
