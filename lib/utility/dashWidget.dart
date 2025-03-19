import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/utility/widget.dart';

Future<String?> fetchUserName(int userId) async {
  final url = Uri.parse(
    'https://6cc5-210-210-144-170.ngrok-free.app/users/$userId',
  );
  print('Fetching user name for ID: $userId from: $url');

  try {
    final response = await http.get(url);
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('User data: $data');

      return data['nama']; // Pastikan key sesuai dengan response dari API
    } else {
      print('Failed to fetch user name: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error fetching user name: $e');
    return null;
  }
}

Widget userInfoRow(
  String label,
  String value,
  String kilokalori, {
  double sizedBoxWidth = 105.0,
  Color valueColor = Colors.black,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customText(label, fontWeight: FontWeight.bold, color: Colors.black),
        SizedBox(width: sizedBoxWidth), // Used parameter here
        customText(
          value,
          color: Color(0xFF2E9D9D),
          fontWeight: FontWeight.bold,
        ),
        customText(
          kilokalori,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ],
    ),
  );
}

Widget userInfoDropdown(
  String label,
  String value,
  Function(String?) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(label, color: Colors.black),
        Container(
          height: 35,
          width: 125,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              onChanged: onChanged,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF1E5172),
                size: 20,
              ),
              items:
                  ["Perempuan", "Laki-laki"]
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: customText(gender, color: Color(0xFF2E9D9D)),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userInfoInput(
  String label,
  TextEditingController Function() getController,
  String unit,
  String hint,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        customText(label, color: Colors.black),
        SizedBox(
          height: 30,
          width: 185,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 125,
                child: TextField(
                  controller: getController(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Color(0xFF2E9D9D),
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              customText(unit, color: Colors.black, fontSize: 14),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<List<Map<String, dynamic>>> fetchFirstFourFoodData() async {
  final url = 'https://6cc5-210-210-144-170.ngrok-free.app/makanan';
  print('Fetching data from: $url');

  try {
    final response = await http.get(Uri.parse(url));
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print('Fetched data: ${data.length} items');

      // Urutkan berdasarkan ID terendah
      data.sort((a, b) => (a['id'] as int).compareTo(b['id'] as int));

      return data
          .take(4)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } else {
      print('Failed to fetch data: ${response.body}');
      throw Exception('Failed to load food data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to load food data');
  }
}

class FoodCard extends StatelessWidget {
  final int id;
  final String imagePath;
  final String title;
  final String calories;

  const FoodCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.calories,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final food = {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'calories': calories,
    };

    return Container(
      width: 160,
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Container
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$calories kkal",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  imagePath,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
