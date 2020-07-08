import 'package:flutter/material.dart';
import 'package:thingtranslator/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Things Translator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple[500],
        accentColor: Colors.yellow[500]
      ),
      home: HomePage(),
    );
  }
}
