import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/utility/bottomNavBar.dart';
import 'package:projects_sehatin/utility/dashWidget.dart';
import 'package:projects_sehatin/utility/widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGender = "Laki-laki";
  TextEditingController myHeightController = TextEditingController();
  TextEditingController myWeightController = TextEditingController();
  TextEditingController myAgeController = TextEditingController();
  int _selectedIndex = 0;

  TextEditingController getMyHeightController() {
    return myHeightController;
  }

  TextEditingController getMyWeightController() {
    return myWeightController;
  }

  TextEditingController getMyAgeController() {
    return myAgeController;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/home");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/musik_tidur");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/love");
        break;
      case 3:
        Navigator.pushReplacementNamed(context, "/konsultasi");
        break;
      case 4:
        Navigator.pushReplacementNamed(context, "/profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.none,
              alignment: Alignment.center,
            ),
          ),

          SingleChildScrollView(
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
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/drsherly.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Info User
                  Text(
                    "Mari kita kurangi beberapa kalori hari ini!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
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
                          getMyHeightController,
                          "cm",
                          35,
                        ),
                        userInfoInput(
                          "Berat Badan:",
                          getMyWeightController,
                          "kg",
                          40,
                        ),
                        userInfoInput("Usia:", getMyAgeController, "tahun", 15),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade400,
                            height: 1,
                          ),
                        ),

                        userInfoRow("Kebutuhan:", "1200", "kilokalori"),
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
                          onPressed: () {},
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
          ),
        ],
      ),
      bottomNavigationBar: CustomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
