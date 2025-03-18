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
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 60,
      backgroundColor: Colors.transparent,
      color: Colors.white,
      buttonBackgroundColor: Colors.teal,
      animationDuration: Duration(milliseconds: 300),
      items: List.generate(5, (index) {
        bool isSelected = selectedIndex == index;
        Color iconColor = isSelected ? Colors.white : Colors.grey;
        Color textColor = isSelected ? Colors.teal : Color(0xFF8D8D8D);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.teal : Colors.transparent,
                ),
                padding: isSelected ? EdgeInsets.all(8) : EdgeInsets.zero,
                child: Icon(
                  _getIcon(index),
                  color: isSelected ? Colors.white : Colors.grey,
                  size: index == 2 ? 28 : 24, // Floating Action Button style di tengah
                ),
              ),
              SizedBox(height: 4),
              Text(
                _getLabel(index),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        );
      }),
      onTap: onItemTapped,
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.music_note;
      case 2:
        return Icons.favorite;
      case 3:
        return Icons.chat;
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
        return "Musik";
      case 2:
        return "Favorit";
      case 3:
        return "Chat";
      case 4:
        return "Profil";
      default:
        return "";
    }
  }
}