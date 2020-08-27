import 'package:flutter/material.dart';

class Setting {
  String title;
  IconData icon;
  Widget newWidget;
  Widget trailingWidget;
  bool language;

  Setting({
    @required this.title,
    this.icon,
    this.newWidget,
    this.trailingWidget,
    this.language,
  });
}
