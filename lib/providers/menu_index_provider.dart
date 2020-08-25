import 'package:flutter/material.dart';

class MenuIndexProvider extends ChangeNotifier {
  var _selectedIndex = 0;

  int get getSelectedIndex {
    return _selectedIndex;
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
