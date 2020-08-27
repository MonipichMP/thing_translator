import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/models/setting.dart';
import 'package:thingtranslator/providers/switch_provider.dart';
import 'package:thingtranslator/providers/theme_provider.dart';
import 'package:thingtranslator/screens/setting_page/about_app_screen.dart';
import 'package:thingtranslator/screens/setting_page/language_screen.dart';
import 'package:easy_localization/easy_localization.dart';

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
      title: Text("setting".tr()),
    );
  }

  Widget buildListSetting(ThemeProvider themeProvider, bool theme) {
    final List<Setting> settingList = [
      Setting(
        title: "theme".tr(),
        icon: Icons.brightness_6,
        trailingWidget: Switch(
          value: theme,
          onChanged: (value) {
            if (themeProvider.getThemeMode() == ThemeMode.light) {
              themeProvider.setThemeMode(ThemeMode.dark);
            } else {
              themeProvider.setThemeMode(ThemeMode.light);
            }
            Provider.of<SwitchProvider>(context, listen: false)
                .setNewTheme(value);
          },
          activeTrackColor: Theme.of(context).primaryColor,
        ),
      ),
      Setting(
        title: "language".tr(),
        icon: Icons.language,
        trailingWidget: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text("english".tr()),
            Icon(Icons.chevron_right),
          ],
        ),
        newWidget: LanguageScreen(),
      ),
      Setting(
        title: "help".tr(),
        icon: Icons.help,
      ),
      Setting(
        title: "contact_us".tr(),
        icon: Icons.perm_contact_calendar,
      ),
      Setting(
        title: "about_app".tr(),
        icon: Icons.info,
        newWidget: AboutAppScreen(),
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
                  leading: Icon(settingList[index].icon),
                  trailing: settingList[index].trailingWidget,
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
