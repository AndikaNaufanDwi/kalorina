import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
     Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', ''); // Hilangkan tanda #
    return Color(int.parse('0xFF$hex')); // Tambahkan FF untuk opasitas penuh
  }

    return CurvedNavigationBar(
      index: selectedIndex,
      height: 55,
      backgroundColor: Colors.transparent,
      color: selectedIndex == 1 ? hexToColor("#202C31") : Colors.white,
      buttonBackgroundColor: Colors.teal,
      animationDuration: Duration(milliseconds: 300),
      items: List.generate(5, (index) {
        bool isSelected = selectedIndex == index;
        Color iconColor = isSelected ? Colors.white : Colors.grey;
        Color textColor = isSelected ? Colors.white : Color(0xFF8D8D8D);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 2
                ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.favorite, color: Colors.white),
                )
                : Icon(_getIcon(index), color: iconColor, size: 22),
            SizedBox(height: 4),
            if (!isSelected)
              Text(
                _getLabel(index),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
          ],
        );
      }),
      onTap: onItemTapped,
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.restaurant;
      case 1:
        return Icons.nights_stay;
      case 2:
        return Icons.favorite;
      case 3:
        return Icons.chat_bubble;
      case 4:
        return Icons.person;
      default:
        return Icons.home;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return "Beranda";
      case 1:
        return "Musik Tidur";
      case 2:
        return "Favorite";
      case 3:
        return "Konsultasi";
      case 4:
        return "Profile";
      default:
        return "";
    }
  }
}
