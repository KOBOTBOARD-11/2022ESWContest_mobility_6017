import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle bigSize1({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: mColor),
  );
}

TextStyle h1({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: mColor),
  );
}

TextStyle h2({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 38, color: mColor),
  );
}

TextStyle h3({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: mColor),
  );
}

TextStyle h4({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: mColor),
  );
}

TextStyle h5({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: mColor),
  );
}

TextStyle subtitle1({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: mColor),
  );
}

TextStyle subtitle2({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: mColor),
  );
}

TextStyle subtitle3({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: mColor),
  );
}

TextStyle overLine({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: mColor),
  );
}

TextStyle body1({Color mColor = Colors.black}) {
  return GoogleFonts.jua(
    textStyle: TextStyle(fontSize: 20, color: mColor),
  );
}

BoxDecoration buttonStyle1({double mRadius = 10, Color mColor = Colors.white}) {
  return BoxDecoration(
    color: mColor,
    borderRadius: BorderRadius.circular(mRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 1),
      )
    ],
  );
}

BoxDecoration buttonStyle2({double mRadius = 10, Color mColor = Colors.white}) {
  return BoxDecoration(
    color: mColor,
    borderRadius: BorderRadius.circular(mRadius),
  );
}
