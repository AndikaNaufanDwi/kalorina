import 'package:flutter/material.dart';
import 'package:projects_sehatin/utility/widget.dart';

class Konsultasi extends StatelessWidget {
  final String? name;
  final String? imgSrc;
  final String? occupation;
  const Konsultasi({super.key, this.name, this.occupation, this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 80,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: ClipOval(
              child: Image.asset(
                'assets/$imgSrc.png',
                fit: BoxFit.contain,
                width: 45,
                height: 45,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                  "$name",
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                ),
                if (occupation != null)
                  customText(
                    occupation!,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
