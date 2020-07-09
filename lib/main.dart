import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/base_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Things Translator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OperatorMono",
        primaryColor: Colors.deepPurple[500],
        accentColor: Colors.amberAccent
      ),
      home: BaseScreen(),
    );
  }
}
