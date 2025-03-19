import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/favoriteFood.dart';
import 'package:projects_sehatin/Screen/konsultasi.dart';
import 'package:projects_sehatin/Screen/playlist.dart';
import 'package:projects_sehatin/Screen/profile.dart';
import 'package:projects_sehatin/utility/bmi_API.dart';
import 'package:projects_sehatin/utility/bottomNavBar.dart';
import 'package:projects_sehatin/utility/controller.dart';
import 'package:projects_sehatin/utility/dashWidget.dart';
import 'package:projects_sehatin/utility/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int i;

  const HomeScreen({super.key, required this.i});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGender = "Laki-laki";
  final TextEditingController _tinggiController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _tahunLahirController = TextEditingController();

  String? _accessToken;
  int? idnya;
  String? userName;

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedId = prefs.getInt('id');
    String? storedToken = prefs.getString('access_token');

    setState(() {
      _accessToken = storedToken;
      idnya = storedId;
    });

    print("Access Token: $_accessToken");
    print("ID: $idnya");

    // Panggil fetchUserName hanya jika idnya tidak null
    if (idnya != null) {
      String? fetchedName = await fetchUserName(idnya!);
      setState(() {
        userName = fetchedName ?? "User tidak ditemukan";
      });
    }
  }

  Future<Map<String, dynamic>>? _foodData;

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
    setState(() {
      _selectedIndex = widget.i;
    });
  }

  String kebutuhanKalori = "0";
  String bmiCategory = "Unknown";
  List<Map<String, dynamic>> foods = [];

  Future<void> handleSubmit() async {
    final response = await submitUserData(
      _tahunLahirController.text,
      _beratController.text,
      _tinggiController.text,
      selectedGender,
      _accessToken ?? "",
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
      case 1:
        return Playlist();
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
                  "Hello, ${userName}",
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

                  Divider(thickness: 1.5, color: Colors.grey.shade400),

                  userInfoRow("Kebutuhan:", kebutuhanKalori, " kkal"),
                  userInfoRow("Indikator BMI:", bmiCategory, ""),

                  Align(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: handleSubmit,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF2E9D9D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
            Text(
              "Rekomendasi Makanan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Hidup sehat, makanan harus dijaga!",
              style: TextStyle(color: Colors.black54),
            ),

            SizedBox(height: 10),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchFirstFourFoodData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // Loading indicator
                } else if (snapshot.hasError) {
                  return Center(child: Text("Gagal mengambil data makanan"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Tidak ada data makanan"));
                }

                final foodList = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        foodList.map((foodData) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: FoodCard(
                              id: foodData['id'],
                              imagePath:
                                  foodData["image_url"] ??
                                  "https://via.placeholder.com/140",
                              title: foodData["nama"] ?? "Nama tidak tersedia",
                              calories:
                                  (foodData["total_kalori"]?.toString() ?? "0"),
                            ),
                          );
                        }).toList(),
                  ),
                );
              },
            ),

            SizedBox(height: 20),
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
      ),
    );
  }
}
