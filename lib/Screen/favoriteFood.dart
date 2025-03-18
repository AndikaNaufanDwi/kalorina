import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/utility/bottomNavBar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 2;

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', ''); // Hilangkan tanda #
    return Color(int.parse('0xFF$hex')); // Tambahkan FF untuk opasitas penuh
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
        Navigator.pushReplacementNamed(context, "/favorite");
        break;
      case 3:
        Navigator.pushReplacementNamed(context, "/konsultasi");
        break;
      case 4:
        Navigator.pushReplacementNamed(context, "/profile");
        break;
    }
  }

  final Map<String, List<Map<String, String>>> foodCategories = {
    "Veg Food": [
      {
        "name": "Chopped Salad",
        "desc": "Romaine lettuce Greek salad",
        "calories": "120 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Tofu",
        "desc": "Green papaya salad Thai cuisine Salted",
        "calories": "175 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Avocado Toast",
        "desc": "Whole grain toast with avocado",
        "calories": "210 kkal",
        "image": "eatmeal.png",
      },
    ],
    "Non-Veg Food": [
      {
        "name": "Roast Chicken",
        "desc": "Roasted chicken with lemons",
        "calories": "300 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Sate Ayam",
        "desc": "Sate ayam dengan bumbu kacang",
        "calories": "250 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Grilled Fish",
        "desc": "Grilled salmon with lemon butter",
        "calories": "200 kkal",
        "image": "eatmeal.png",
      },
    ],
    "Mixed": [
      {
        "name": "Chicken Salad",
        "desc": "Mixed salad with grilled chicken",
        "calories": "180 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Seafood Pasta",
        "desc": "Pasta with shrimp and calamari",
        "calories": "320 kkal",
        "image": "eatmeal.png",
      },
      {
        "name": "Burger",
        "desc": "Whole grain bun with beef patty",
        "calories": "400 kkal",
        "image": "eatmeal.png",
      },
    ],
  };

  void _showDeleteConfirmation(BuildContext context, String foodName) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ilustrasi (Gunakan Image.asset jika memiliki gambar lokal)
              Image.asset('assets/HapusFavorit.png', height: 150),
              SizedBox(height: 20),

              // Teks Konfirmasi
              Text(
                "Apakah anda yakin ingin menghapus?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Tombol "Ya, Hapus"
              GestureDetector(
                onTap: () {
                  // Logika hapus item favorit
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ya, Hapus",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF44336),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Tombol "Tidak"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Tidak",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true, // Agar background menutupi AppBar
    body: Stack(
      children: [
        /// **Background Image**
        Positioned.fill(
          child: Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover, // Menutupi seluruh layar
          ),
        ),

        /// **Konten Utama**
        /// 
    
        Padding(
          padding: EdgeInsets.all(16.0),
          child:  ListView(
            children: foodCategories.keys.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: hexToColor("#343434"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodCategories[category]!.length,
                      itemBuilder: (context, index) {
                        return _buildFoodCard(
                          foodCategories[category]![index],
                          cardHeight: 230,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            }).toList(),
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


  Widget _buildFoodCard(Map<String, String> food, {double cardHeight = 230}) {
    return SizedBox(
      width: 180,
      height: cardHeight,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: hexToColor("#2E9D9D"),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  _showDeleteConfirmation(context, food['name']!);
                },
                child: Icon(Icons.favorite, color: Colors.red, size: 24),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/${food["image"]}',
                      height: 90,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    food['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    food['desc']!,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
