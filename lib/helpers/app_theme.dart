import 'package:flutter/material.dart';

class AppTheme {
  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: "OperatorMono",
        primaryColor: Colors.deepPurple[500],
        accentColor: Colors.amberAccent,
        scaffoldBackgroundColor: Colors.black87,
        accentIconTheme: IconThemeData(color: Colors.white),
      );

  get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: "OperatorMono",
        primaryColor: Colors.deepPurple[500],
        accentColor: Colors.amberAccent,
        scaffoldBackgroundColor: Colors.grey[200],
        accentIconTheme: IconThemeData(color: Colors.black),
      );
}
