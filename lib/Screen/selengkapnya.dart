import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelengkapnyaScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SelengkapnyaScreen> {
  final List<String> categories = ["Veg Food", "Non-Veg Food", "Mixed"];
  int selectedIndex = 0;

  final List<Map<String, String>> foods = [
    {
      "name": "Sapo Tahu",
      "desc": "Masakan vegetarian sayurrrrrrrrr asdjasjdoasjio",
      "calories": "350 kkal",
      "image": "buffet_food.png",
    },
    {
      "name": "Ketoprak",
      "desc": "Ketupat, tahu, bihun, lontong",
      "calories": "290 kkal",
      "image": "matter_paneer.png",
    },
    {
      "name": "Tofu",
      "desc": "Tofu with lettuce n tomato on plate",
      "calories": "175 kkal",
      "image": "tofu.png",
    },
    {
      "name": "Oatmeal",
      "desc": "Oatmeal banana and blueberry",
      "calories": "89 kkal",
      "image": "eatmeal.png",
    },
        {
      "name": "Tofu",
      "desc": "Tofu with lettuce n tomato on plate",
      "calories": "175 kkal",
      "image": "tofu.png",
    },
    {
      "name": "Oatmeal",
      "desc": "Oatmeal banana and blueberry",
      "calories": "89 kkal",
      "image": "eatmeal.png",
    }
  ];

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', ''); // Hilangkan tanda #
    return Color(int.parse('0xFF$hex')); // Tambahkan FF untuk opasitas penuh
  }

  // Fungsi untuk memotong teks jika lebih dari 20 kata
  String _trimDescription(String desc) {
    List<String> words = desc.split(" ");
    if (words.length > 20) {
      return words.take(18).join(" ") + "..."; // Ambil 18 kata + '...'
    }
    return desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#FFFFFF"),
      appBar: AppBar(
        title: Text(
          "Rekomendasi Makanan",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: hexToColor("#343434"),
            letterSpacing: 3.5 / 100,
            height: 152 / 100,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
                                  Navigator.pushNamed(context, '/home');

          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ), // Padding kiri & kanan
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Membuat distribusi rata
                children:
                    categories.map((category) {
                      int index = categories.indexOf(category);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
  category,
  style: TextStyle(
    fontSize: 18,
    fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
    color: selectedIndex == index ? Colors.teal : Colors.grey,
    shadows: selectedIndex == index
        ? [
            Shadow(
              color: Colors.black.withOpacity(0.2), // Warna bayangan
              offset: Offset(0, 1), // Arah bayangan (x, y)
              blurRadius: 4, // Seberapa blur bayangannya
            ),
          ]
        : [],
  ),
),

                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 260, // Atur tinggi item menjadi 200
                  crossAxisSpacing: 17,
                  mainAxisSpacing: 17,
                ),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];

                  // Menentukan warna berdasarkan pola
                  final color =
                      (index % 4 == 0 || index % 4 == 3)
                          ? hexToColor("#F0F8F8")
                          : hexToColor("#D5E7F3");

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: food);
                    },
                   child: Container(
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Warna bayangan
        blurRadius: 2, // Seberapa blur bayangannya
        spreadRadius: 1, // Seberapa jauh bayangan menyebar
        offset: Offset(0, 2), // Posisi bayangan (x, y)
      ),
    ],
  ),
  padding: EdgeInsets.all(12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Image.asset(
          'assets/images/${food["image"]}',
          height: 120,
        ),
      ),
      SizedBox(height: 10),
      Text(
        food["name"]!,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: hexToColor("#343434"),
          letterSpacing: 3.5 / 100,
          height: 152 / 100,
        ),
      ),
      SizedBox(height: 3),
      Text(
        _trimDescription(food["desc"]!),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: hexToColor("#343434"),
          letterSpacing: 3.5 / 100,
          height: 152 / 100,
        ),
      ),
      SizedBox(height: 12),
      Text(
        food["calories"]!,
        style: TextStyle(
          color: hexToColor("#E30F00"),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
