import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[300],
      cardColor: Colors.lightBlue[50],
      indicatorColor: Colors.grey[700],
      primaryTextTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
        titleMedium: GoogleFonts.alata(fontSize: 24, color: Colors.grey[700]),
        titleLarge: GoogleFonts.aBeeZee(fontSize: 28, color: Colors.grey[700]),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey[800],
      cardColor: Colors.blueGrey,
      indicatorColor: Colors.white,
      primaryTextTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        titleMedium: GoogleFonts.alata(fontSize: 24, color: Colors.white),
        titleLarge: GoogleFonts.aBeeZee(fontSize: 28, color: Colors.white),
      ),
    );
  }
}
