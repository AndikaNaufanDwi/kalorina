import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/utility/konsulWidget.dart';
import 'package:projects_sehatin/utility/widget.dart';

class KonsultasiScreen extends StatefulWidget {
  @override
  _KonsultasiScreenState createState() => _KonsultasiScreenState();
}

class _KonsultasiScreenState extends State<KonsultasiScreen> {
  bool _isLocked = true;

  void _showSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFDCDCDC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actionsPadding: EdgeInsets.zero,
          title: Center(
            child: customText(
              "Lanjut berlangganan?",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Kamu bisa membatalkan langganan kapan pun kamu mau.",
                style: GoogleFonts.roboto(
                  color: Color(0xFF000000),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                Divider(height: 1, color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.roboto(color: Color(0xFF0038FF)),
                        ),
                      ),
                    ),
                    Container(height: 48, width: 1, color: Colors.grey),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLocked = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ya!",
                          style: GoogleFonts.roboto(color: Color(0xFF0038FF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: customText(
                    "Konsultasi",
                    color: Color(0xFF222B45),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Center(
                  child: Konsultasi(
                    name: "Chat AI",
                    imgSrc: "drsherlys",
                    url: "https://chatgpt.com/",
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Konsultasi(
                    name: "dr. Dedy Codeva ",
                    imgSrc: "doktor",
                    occupation: "Ahli Gizi",
                    url: "https://wa.me/+6281381218850",
                  ),
                ),
              ],
            ),
          ),
          if (_isLocked)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 80, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      "Oops kamu belum berlangganan :(",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Kamu harus berlangganan terlebih dahulu untuk bisa mengakses fitur konsultasi.",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _showSubscriptionDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E9D9D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: customText("Berlangganan Sekarang!"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
