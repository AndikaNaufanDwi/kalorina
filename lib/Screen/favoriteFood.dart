import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/utility/bottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 2;
  String? _accessToken;
  Map<String, List<Map<String, String>>> foodCategories = {
    "Veg Food": [],
    "Non-Veg Food": [],
    "Mixed": [],
  };
  bool isLoading = true;

  String _trimDescription(String desc) {
    print(desc);
    List<String> words = desc.split(" ");
    if (words.length > 14) {
      return words.take(18).join(" ") + "..."; // Ambil 18 kata + '...'
    }
    return desc;
  }

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
  }

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = prefs.getString('access_token');
    });

    if (_accessToken != null) {
      await _fetchFavoriteFoods();
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteFood(BuildContext context, int makananId) async {
    final String baseUrl = "https://6cc5-210-210-144-170.ngrok-free.app";
    final String url = "$baseUrl/makanan/$makananId/like";
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop(); // Tutup modal setelah sukses
      } else {
        _showErrorDialog(context, "Gagal menghapus makanan");
      }
    } catch (e) {
      _showErrorDialog(context, "Terjadi kesalahan: $e");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchFavoriteFoods() async {
    final url = Uri.parse(
      "https://6cc5-210-210-144-170.ngrok-free.app/makanan/favorite",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_accessToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> foods = json.decode(response.body);

        setState(() {
          for (var food in foods) {
            if (food["kategori_id"] == null ||
                food["id"] == null ||
                food["nama"] == null) {
              continue; // Skip jika ada data yang tidak valid
            }

            String category = _mapCategory(food["kategori_id"]);

            // Pastikan kategori tersedia di foodCategories
            foodCategories.putIfAbsent(category, () => []);

            foodCategories[category]?.add({
              "id": food["id"].toString(),
              "name": food["nama"],
              "desc": food["deskripsi"] ?? "",
              "calories": "${food["total_kalori"] ?? 0} kkal",
              "image": food["image_url"] ?? "default.png",
            });
          }
        });
      } else {
        print("Gagal mengambil makanan favorit: ${response.body}");
      }
    } catch (e) {
      print("Error saat mengambil makanan favorit: $e");
    }
  }

  String _mapCategory(int kategoriId) {
    switch (kategoriId) {
      case 1:
        return "Veg Food";
      case 2:
        return "Non-Veg Food";
      default:
        return "Mixed";
    }
  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    return Color(int.parse('0xFF$hex'));
  }

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
              Image.asset('assets/HapusFavorit.png', height: 150),
              SizedBox(height: 20),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/favorite");
                  _deleteFood(context, int.parse(foodName));
                  print("Menghapus $foodName");
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
    bool hasFavorites = foodCategories.values.any((list) => list.isNotEmpty);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child:
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : hasFavorites
                    ? ListView(
                      children:
                          foodCategories.entries
                              .where((entry) => entry.value.isNotEmpty)
                              .map((entry) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.key,
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
                                        itemCount: entry.value.length,
                                        itemBuilder: (context, index) {
                                          return _buildFoodCard(
                                            entry.value[index],
                                            cardHeight: 280,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                );
                              })
                              .toList(),
                    )
                    : Center(
                      child: Text(
                        "Belum ada makanan favorit user",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(Map<String, String> food, {double cardHeight = 280}) {
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
                  print(food);
                  _showDeleteConfirmation(context, food['id']!);
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
                    child: Image.network(
                      food['image'] ??
                          "https://png.pngtree.com/png-clipart/20220430/ourmid/pngtree-makanan-indonesia-nasi-goreng-png-image_4559599.png",
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported, size: 120);
                      },
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
                    _trimDescription(food["desc"]!),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: hexToColor("#FFFFFF"),
                      letterSpacing: 3.5 / 100,
                      height: 152 / 100,
                    ),
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
