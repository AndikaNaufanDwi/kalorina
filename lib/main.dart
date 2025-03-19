import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/dashboard.dart';
import 'package:projects_sehatin/Screen/konsultasi.dart';
import 'package:projects_sehatin/Screen/detail.dart';
import 'package:projects_sehatin/Screen/favoriteFood.dart';
import 'package:projects_sehatin/Screen/playlist.dart';
import 'package:projects_sehatin/Screen/favplaylist.dart';
import 'package:projects_sehatin/Screen/selengkapnya.dart';
import 'package:projects_sehatin/Screen/splash.dart';
import 'package:projects_sehatin/Screen/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sehat-in',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/detail': (context) => DetailScreen(),
        '/selengkapnya': (context) => SelengkapnyaScreen(),
        '/favorite': (context) => FavoriteScreen(),
        '/profile': (context) => ProfileScreen(),
        '/playlist': (context) => Playlist()
      },
    );
  }
}
