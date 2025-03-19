import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _accessToken;

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = prefs.getString('access_token');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
  }

  Future<void> _likeFood(int makananId) async {
    if (_accessToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Token tidak tersedia, silakan login ulang!")),
      );
      return;
    }

    final url = Uri.parse(
      'https://6cc5-210-210-144-170.ngrok-free.app/makanan/$makananId/like',
    );

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil menambahkan ke favorit!")),
        );
        // Navigator.pushNamed(context, '/favorite');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(i: 2)),
        );
        //         });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menambahkan ke favorit: ${response.body}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final food =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Color hexToColor(String hex) {
      hex = hex.replaceFirst('#', '');
      return Color(int.parse('0xFF$hex'));
    }

    return Scaffold(
      backgroundColor: hexToColor("#2E9D9D"),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        food["name"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  food["image"],
                  height: 220,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 200);
                  },
                  colorBlendMode: BlendMode.dstATop,
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.47,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.53,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _nutritionInfo(
                        "Calorie",
                        food["calories"] + " kkal",
                        Colors.red,
                      ),
                      _nutritionInfo(
                        "Protein",
                        food["protein"] + " gm",
                        Colors.black,
                      ),
                      _nutritionInfo("Fat", food["fat"] + " gm", Colors.blue),
                      _nutritionInfo(
                        "Fibre",
                        food["fibre"] + " gm",
                        Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Deskripsi :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        food["desc"]?.toString() ?? "Deskripsi tidak tersedia",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hexToColor("#2E9D9D"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(0, 50),
                        ),
                        onPressed: () => _likeFood(food['id']),
                        child: const Text(
                          "Tambah ke Favorit",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutritionInfo(String label, String value, Color color) {
    return Column(
      children: [
        SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 1),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
