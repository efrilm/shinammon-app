import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BoxShadow shadow = BoxShadow(
  offset: Offset(0, 4),
  color: kBlackColor.withOpacity(0.1),
  blurRadius: 10,
);

Color kPrimaryColor = Color(0xFF357C3C);
Color kBlackColor = Color(0xFF292E39);
Color kBlueColor = Color(0xFF5B7DB1);
Color kGreyColor = Color(0xFFA4A69C);
Color kGreyLightColor = kGreyColor.withOpacity(0.2);
Color kWhiteColor = Color(0xFFFCFCFC);

double hMargin = 20;
double dRadius = 8;

FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);

TextStyle blueTextStyle = GoogleFonts.poppins(
  color: kBlueColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);
