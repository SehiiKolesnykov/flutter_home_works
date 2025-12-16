import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const Color netflixRed = Color(0xFFE50914);

  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.roboto(fontSize: 16),
    bodyMedium: GoogleFonts.roboto(fontSize: 14),
    labelLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
  );
}