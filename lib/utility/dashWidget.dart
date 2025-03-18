import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/utility/widget.dart';

Widget userInfoRow(
  String label,
  String value,
  String kilokalori, {
  Color valueColor = Colors.black,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customText(label, fontWeight: FontWeight.bold, color: Colors.black),
        SizedBox(width: 105),
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
  double paddingText,
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
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

class FoodCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String calories;

  const FoodCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
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
              child: Container(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Food Title
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

                    // Calorie Count
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
          ),

          // Food Image Positioned Above
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  imagePath,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
