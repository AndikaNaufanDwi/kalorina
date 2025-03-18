import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String gender = 'Perempuan';
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: buildTextField('Nama Depan', 'Ayu Dewi')),
                SizedBox(width: 10),
                Expanded(child: buildTextField('Nama Belakang', 'Anantha')),
              ],
            ),
            buildTextField('Tanggal Lahir', '06.12.1992', isDate: true),
            SizedBox(height: 10),
            Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: buildGenderButton('Laki-laki'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: buildGenderButton('Perempuan'),
                ),
              ],
            ),
            buildTextField('Nomor Telp', '081243000758'),
            buildTextField('E-mail', 'ayudewi@gmail.com'),
            buildPasswordField('Password', obscurePassword, () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            }),
            buildPasswordField('Konfirmasi Password', obscureConfirmPassword, () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder, {bool isDate = false}) {
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
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: gender == title ? Colors.blue : Colors.grey.shade300),
          color: gender == title ? Colors.blue.withOpacity(0.1) : Colors.white,
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  Widget buildPasswordField(String label, bool obscureText, VoidCallback toggleVisibility) {
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
