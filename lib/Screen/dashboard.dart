import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/favoriteFood.dart';
import 'package:projects_sehatin/Screen/konsultasi.dart';
import 'package:projects_sehatin/Screen/profile.dart';
import 'package:projects_sehatin/utility/bmi_API.dart';
import 'package:projects_sehatin/utility/bottomNavBar.dart';
import 'package:projects_sehatin/utility/controller.dart';
import 'package:projects_sehatin/utility/dashWidget.dart';
import 'package:projects_sehatin/utility/widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGender = "Laki-laki";
  final TextEditingController _tinggiController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _tahunLahirController = TextEditingController();
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc0MjMwNjg3OSwianRpIjoiMjU0MTc2MjEtYWJkMi00YmMwLTlmNWQtYTMwNzU3OWQ0MTlkIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjEiLCJuYmYiOjE3NDIzMDY4NzksImNzcmYiOiI1MjY5MGZhYi1lZWQzLTQ1ZDctYTkxMS0wNzM1MTkwMTIwNzgiLCJleHAiOjE3NDIzOTMyNzl9.F2ePkHW2C4Wvt99m1dtIY0qYkfqlphLTbChyItQwKw8";

  // State variables for calculated values
  String kebutuhanKalori = "0";
  String bmiCategory = "Unknown";

  Future<void> handleSubmit() async {
    final response = await submitUserData(
      _tahunLahirController.text,
      _beratController.text,
      _tinggiController.text,
      selectedGender,
      token,
    );

    if (response != null) {
      setState(() {
        kebutuhanKalori = response["recommended calorie intake"].toString();
        bmiCategory = response["status"];
      });
    }
  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return FavoriteScreen();
      case 2:
        return FavoriteScreen();
      case 3:
        return KonsultasiScreen();
      case 4:
        return ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          _getScreen(_selectedIndex),
        ],
      ),
      bottomNavigationBar: CustomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                  "Hello, Ayu",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E9D9D),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: hexToColor("#2e9d9d"), width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/drsherly.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Info User
            Text(
              "Mari kita kurangi",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: hexToColor("#747474"),
              ),
            ),
            Text(
              "beberapa kalori hari ini!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: hexToColor("#1E5172"),
              ),
            ),
            SizedBox(height: 20),

            // User Info Container
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  userInfoDropdown("Jenis Kelamin:", selectedGender, (
                    String? newValue,
                  ) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  }),

                  userInfoInput(
                    "Tinggi Badan:",
                    () => _tinggiController,
                    "cm",
                    "00",
                  ),
                  userInfoInput(
                    "Berat Badan:",
                    () => _beratController,
                    "kg",
                    "00",
                  ),
                  userInfoInput(
                    "Tahun Lahir:",
                    () => _tahunLahirController,
                    "",
                    "YYYY-MM-DD",
                  ),

                  // Divider
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade400,
                      height: 1,
                    ),
                  ),

                  // Updated values based on input
                  userInfoRow(
                    "Kebutuhan:",
                    kebutuhanKalori,
                    " kkal",
                    sizedBoxWidth: 130,
                  ),
                  userInfoRow(
                    "Indikator BMI:",
                    bmiCategory,
                    "",
                    sizedBoxWidth: 90,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: handleSubmit,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF2E9D9D),
                        side: BorderSide(
                          color: Color(0xFF2E9D9D),
                          width: 1,
                        ), // Outline hitam
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ), // Padding
                      ),
                      child: customText(
                        "Cek",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Food Recommendations
            Text(
              "Rekomendasi Makanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Hidup sehat, makanan harus dijaga!",
              style: TextStyle(color: Colors.black54),
            ),

            // Food Cards
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FoodCard(
                          imagePath: "assets/beranda_1.png",
                          title: "Oatmeal Pisang dan Blueberry",
                          calories: "89",
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        FoodCard(
                          imagePath: "assets/beranda_2.png",
                          title: "Ayam Panggang",
                          calories: "175",
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        FoodCard(
                          imagePath: "assets/beranda_2.png",
                          title: "Ayam Panggang 2",
                          calories: "175",
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        FoodCard(
                          imagePath: "assets/beranda_2.png",
                          title: "Burger tapi boong",
                          calories: "175",
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/selengkapnya");
                    },
                    child: Text(
                      "Lihat Selengkapnya",
                      style: GoogleFonts.roboto(
                        color: Colors.teal.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}