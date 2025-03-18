import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customText(
  String text, {
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  TextDecoration decoration = TextDecoration.none,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.center,
}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: Colors.white,
    ),
    textAlign: textAlign,
  );
}

class CustomTextSpan extends StatelessWidget {
  final String text;
  final String highlightedText;
  final TextStyle? textStyle;
  final TextStyle? highlightedStyle;
  final Widget targetPage; // Halaman tujuan

  const CustomTextSpan({
    required this.text,
    required this.highlightedText,
    required this.targetPage, // Parameter halaman tujuan
    this.textStyle,
    this.highlightedStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style:
            textStyle ?? GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        children: [
          WidgetSpan(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => targetPage),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                highlightedText,
                style:
                    highlightedStyle ??
                    GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
