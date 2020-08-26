import 'package:flutter/material.dart';

class Setting {
  String title;
  String icon;
  Widget newWidget;
  bool isTrailing;

  Setting({
    @required this.title,
    @required this.icon,
    this.newWidget,
    this.isTrailing,
  });
}
