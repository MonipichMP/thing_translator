import 'package:flutter/material.dart';

class MenuIndexProvider extends ChangeNotifier {
  var _selectedIndex = 0;
  var segmentIndex = 0;

  int get getSelectedIndex {
    return _selectedIndex;
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get getSegmentIndex {
    return segmentIndex;
  }

  void updateSegmentIndex(int index) {
    segmentIndex = index;
    notifyListeners();
  }
}
