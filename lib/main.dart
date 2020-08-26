import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/providers/Label_list_provider.dart';
import 'package:thingtranslator/providers/history_provider.dart';
import 'package:thingtranslator/providers/menu_index_provider.dart';
import 'package:thingtranslator/providers/translation_provider.dart';
import 'package:thingtranslator/screens/base_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuIndexProvider()),
        ChangeNotifierProvider(create: (_) => LabelListProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MaterialApp(
        title: 'Things Translator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "OperatorMono",
            primaryColor: Colors.deepPurple[500],
            accentColor: Colors.amberAccent),
        home: BaseScreen(),
      ),
    );
  }
}
