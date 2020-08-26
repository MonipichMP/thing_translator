import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool isDark = false;
  bool isEnglish = false;

  bool get getTheme {
    return isDark;
  }

  bool get getLanguage {
    return isEnglish;
  }

  void setNewTheme(bool value) {
    isDark = value;
    notifyListeners();
  }

  void setNewLanguage(bool value) {
    isEnglish = value;
    notifyListeners();
  }
}
