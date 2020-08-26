import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/models/setting.dart';
import 'package:thingtranslator/providers/switch_provider.dart';
import 'package:thingtranslator/providers/theme_provider.dart';
import 'package:thingtranslator/screens/setting_page/about_app_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<SwitchProvider>(context);
    var language = Provider.of<SwitchProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          buildListSetting(themeProvider, theme.getTheme),
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Setting"),
    );
  }

  Widget buildListSetting(ThemeProvider themeProvider, bool theme) {
    final List<Setting> settingList = [
      Setting(
        title: "Change Themes",
        icon: "assets/images/theme_icon.png",
        isTrailing: true,
      ),
      Setting(
        title: "Change Languages",
        icon: "assets/images/language_icon.png",
        isTrailing: false,
      ),
      Setting(
        title: "Help",
        icon: "assets/images/help_icon.png",
        isTrailing: false,
      ),
      Setting(
        title: "Contact Us",
        icon: "assets/images/contact_us_icon.png",
        isTrailing: false,
      ),
      Setting(
        title: "About App",
        icon: "assets/images/about_icon.png",
        newWidget: AboutAppScreen(),
        isTrailing: false,
      ),
    ];

    void onTap(Widget newWidget) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => newWidget,
      ));
    }

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: settingList.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Material(
                child: ListTile(
                  title: Text(settingList[index].title),
                  leading: Image.asset(
                    settingList[index].icon,
                    width: 22,
                    height: 22,
                  ),
                  trailing: settingList[index].isTrailing
                      ? Switch(
                          key: Key(settingList[index].title),
                          value: theme,
                          onChanged: (value) {
                            if (themeProvider.getThemeMode() ==
                                ThemeMode.light) {
                              themeProvider.setThemeMode(ThemeMode.dark);
                            } else {
                              themeProvider.setThemeMode(ThemeMode.light);
                            }
                            Provider.of<SwitchProvider>(context, listen: false)
                                .setNewTheme(value);
                            print('value $value');
                          },
                          activeTrackColor: Theme.of(context).primaryColor,
                        )
                      : null,
                  onTap: () {
                    if (settingList[index].newWidget != null) {
                      onTap(settingList[index].newWidget);
                    }
                  },
                ),
              ),
              Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}
