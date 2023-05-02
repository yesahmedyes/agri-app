import 'package:flutter/material.dart';

const Color darkGreenColor = Color(0xFF1c6654);
const Color lightGreenColor = Colors.green;
const Color blueGreenColor = Color(0xFF2E7A77);
const Color blueColor = Color.fromRGBO(61, 139, 255, 1);

ThemeData theme() {
  return ThemeData(
    primaryColor: blueGreenColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.transparent), backgroundColor: darkGreenColor),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 20, height: 1.8, fontWeight: FontWeight.w500, color: Colors.black87),
      headline2: TextStyle(fontSize: 18, height: 1.8, fontWeight: FontWeight.w500, color: Colors.black87),
      headline3: TextStyle(fontSize: 16, height: 1.8, fontWeight: FontWeight.w500, color: Colors.black),
      headline4: TextStyle(fontSize: 14, color: Colors.grey),
      bodyText1: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w400, color: Colors.black),
      bodyText2: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: Colors.black),
      subtitle1: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: Colors.black87, letterSpacing: 1),
      subtitle2: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: blueColor, decoration: TextDecoration.underline),
    ),
    fontFamily: 'Roboto',
  );
}
