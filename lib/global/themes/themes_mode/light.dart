import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData lightThemes = ThemeData.light().copyWith(
    textTheme: TextTheme(
        titleLarge: GoogleFonts.alata(
          fontSize: 26,
          fontWeight: FontWeight.w400,
          color: ColorManager.firstBlack,
        ),
        titleMedium: GoogleFonts.alata(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: ColorManager.firstBlack,
        ),
        titleSmall: GoogleFonts.alata(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: ColorManager.firstBlack,
        ),
        bodyLarge: GoogleFonts.alata(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorManager.firstBlack,
        ),
        bodyMedium: GoogleFonts.alata(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ColorManager.firstBlue,
        ),
        bodySmall: GoogleFonts.alata(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.firstBlack,
        ),


      displayMedium:  GoogleFonts.alata(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorManager.secondBlue,
      ),


    ));
