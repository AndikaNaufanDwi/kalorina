import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String gender = 'Perempuan';
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MjMwNjg3OSwianRpIjoiMjU0MTc2MjEtYWJkMi00YmMwLTlmNWQtYTMwNzU3OWQ0MTlkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjEiLCJuYmYiOjE3NDIzMDY4NzksImNzcmYiOiI1MjY5MGZhYi1lZWQzLTQ1ZDctYTkxMS0wNzM1MTkwMTIwNzgiLCJleHAiOjE3NDIzOTMyNzl9.F2ePkHW2C4Wvt99m1dtIY0qYkfqlphLTbChyItQwKw8';
  String apiUrl = 'http://127.0.0.1:5000/users';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> updateUser() async {
    try {
      print('Updating user...');
      print('API URL: $apiUrl');
      print('Token: $token');

      final Map<String, dynamic> requestBody = {
        "nama": "${firstNameController.text} ${lastNameController.text}",
        "email": emailController.text,
        "password":
            passwordController.text.isNotEmpty ? passwordController.text : "",
      };

      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile.')));
      }
    } catch (e) {
      print('Error updating user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.green),
            onPressed: updateUser,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/drsherly.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFF2E9D9D),
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildTextField('Nama Depan', firstNameController),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildTextField('Nama Belakang', lastNameController),
                  ),
                ],
              ),
              buildTextFieldCustom('Tanggal Lahir', '06.12.1992', isDate: true),
              SizedBox(height: 10),
              Text(
                'Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(child: buildGenderButton('Laki-laki')),
                  SizedBox(width: 10),
                  Expanded(child: buildGenderButton('Perempuan')),
                ],
              ),
              SizedBox(height: 10),

              buildTextField('E-mail', emailController),
              buildPasswordField('Password', obscurePassword, () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              }),
              buildPasswordField(
                'Konfirmasi Password',
                obscureConfirmPassword,
                () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isDate = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          suffixIcon: isDate ? Icon(Icons.calendar_today) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldCustom(
    String label,
    String placeholder, {
    bool isDate = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          suffixIcon: isDate ? Icon(Icons.calendar_today) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget buildGenderButton(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: gender == title ? Color(0xFF2E9D9D) : Colors.grey.shade300,
            width: 2,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              value: title,
              groupValue: gender,
              onChanged: (String? value) {
                setState(() {
                  gender = value!;
                });
              },
              activeColor: Color(0xFF2E9D9D),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField(
    String label,
    bool obscureText,
    VoidCallback toggleVisibility,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: toggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
