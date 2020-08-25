import 'package:flutter/material.dart';
import 'package:thingtranslator/apis/translate_api.dart';

class TranslationProvider extends ChangeNotifier {
  String translateWord = "";

  String get getTranslateWord {
    return translateWord;
  }

  void setNewTranslateWord(String word){
    var list = TranslateAPI().getTranslateText(word);
    list.then((value) {
      translateWord = value.translatedText;
      notifyListeners();
    });
  }
}