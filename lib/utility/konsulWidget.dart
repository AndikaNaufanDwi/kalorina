import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projects_sehatin/utility/widget.dart';

class Konsultasi extends StatelessWidget {
  final String? name;
  final String? imgSrc;
  final String? occupation;
  final String? url; // Add URL

  const Konsultasi({
    super.key,
    this.name,
    this.occupation,
    this.imgSrc,
    this.url,
  });

  // Function to launch URL
  void _launchURL(BuildContext context) async {
    if (url != null && await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url!), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cannot open URL')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 350,
        height: 80,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  if (occupation != null)
                    customText(occupation!, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
