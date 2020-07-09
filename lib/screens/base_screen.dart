import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thingtranslator/screens/home_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
    );

    final menuScreens = [
      HomeScreen(),
      Center(child: Text("History")),
      Center(child: Text("Setting")),
    ];

    return Scaffold(
        backgroundColor: Colors.grey[150],
        body: menuScreens.elementAt(selectedIndex),
        bottomNavigationBar: bottomNavBar);
  }
}
//
// Padding(
//             padding: EdgeInsets.all(10.0),
//             child: TextField(
//               controller: value,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Please input image URL',
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
