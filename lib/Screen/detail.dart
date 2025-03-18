import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final food =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

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
                child: Image.asset(
                  'assets/images/${food["image"]}',
                  height: 280,
                  width: 280,
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
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        // topRight: Radius.circular(30),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        // Nutrition Info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _nutritionInfo("Calorie", "5 kkal", Colors.red),
            _nutritionInfo("Protein", "7 gm", Colors.black),
            _nutritionInfo("Fat", "20 gm", Colors.blue),
            _nutritionInfo("Fibre", "5 gm", Colors.green),
          ],
        ),

        const SizedBox(height: 30),

        // Deskripsi Title
        const Text(
          "Deskripsi :",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Deskripsi Content
        const Expanded(
          child: SingleChildScrollView(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper sed vulputate lobortis interdum tempor odio. Cras dolor ultrices et blandit sem non, commodo. "
              "Aliquet sagittis lorem etiam in molestie in. Ornare non cursus diam turpis vitae. \n\n"
              "Aliquet sagittis lorem etiam in molestie in. Ornare non cursus diam turpis vitae.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ),
        

        const SizedBox(height: 20),

        // Button
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
              onPressed: () {
                Navigator.pushNamed(context, '/favorite');
              },
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

  Widget _nutritionInfo(String label, String value, Color color, [IconData? icon]) {
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
