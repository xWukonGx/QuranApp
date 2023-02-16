import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromARGB(255, 26, 67, 78);
const Color cardColor = Color.fromARGB(255, 229, 223, 245);
const Color backDColor = Color.fromARGB(255, 24, 24, 24);
const Color carDColor = Color.fromARGB(255, 37, 37, 37);

const Color textWhite = Colors.white;
ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: backDColor,
    backgroundColor: Colors.white,
    shadowColor: backgroundColor.withOpacity(0.5),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontFamily: 'Cairo', color: Colors.white))),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black54, elevation: 0),
    textTheme: TextTheme(
        headline4: TextStyle(color: Colors.black, fontFamily: 'ahh'),
        headline2: TextStyle(color: Colors.black, fontFamily: 'ahh'),
        headline5: TextStyle(color: Colors.black, fontFamily: 'Cairo'),
        headline6: TextStyle(color: Colors.black87, fontFamily: 'Tajwal'),
        subtitle2: TextStyle(color: Colors.black54, fontFamily: 'Cairo'),
        button: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
    buttonTheme: ButtonThemeData(
        buttonColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 15)));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    cardColor: carDColor,
    textTheme: TextTheme(
      subtitle2: TextStyle(color: Colors.white54, fontFamily: 'Cairo'),
      headline5: TextStyle(color: backgroundColor, fontFamily: 'Cairo'),
      headline6:
          TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: 'Tajwal'),
      headline4:
          TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: 'ahh'),
      headline2: TextStyle(
          color: Color.fromARGB(255, 243, 243, 243), fontFamily: 'ahh'),
      button: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
    ),
    shadowColor: backDColor.withOpacity(0.5),
    backgroundColor: backDColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 0, 141, 180)),
    buttonTheme: ButtonThemeData(
        buttonColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 15)));
