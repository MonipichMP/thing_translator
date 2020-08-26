import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/providers/menu_index_provider.dart';
import 'package:thingtranslator/screens/history_page/history_screen.dart';
import 'package:thingtranslator/screens/home_page/home_screen.dart';
import 'package:thingtranslator/screens/setting_page/setting_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedIndex = Provider.of<MenuIndexProvider>(context);

    void onTap(int index) {
      Provider.of<MenuIndexProvider>(context, listen: false)
          .updateSelectedIndex(index);
    }

    final bottomNavBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              width: 35,
              height: 35,
            ),
            title: Text("Home")),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/history.svg",
              width: 35,
              height: 35,
            ),
            title: Text("History")),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/setting.svg",
              width: 35,
              height: 35,
            ),
            title: Text("Setting")),
      ],
      currentIndex: selectedIndex.getSelectedIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
    );

    final menuScreens = [
      HomeScreen(),
      HistoryScreen(),
      SettingScreen(),
    ];

    return Scaffold(
        backgroundColor: Colors.grey[150],
        body: menuScreens.elementAt(selectedIndex.getSelectedIndex),
        bottomNavigationBar: bottomNavBar);
  }
}
