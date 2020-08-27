import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/models/setting.dart';
import 'package:thingtranslator/providers/switch_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var language = Provider.of<SwitchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildList(context, language.getLanguage),
        ],
      ),
    );
  }

  Widget buildList(BuildContext context, bool isLanguage) {
    final languageList = [
      Setting(
        title: "English",
        trailingWidget: isLanguage ? Icon(Icons.check) : null,
        language: isLanguage,
      ),
      Setting(
          title: "ភាសាខ្មែរ",
          trailingWidget: !isLanguage ? Icon(Icons.check) : null,
          language: !isLanguage),
    ];

    return Column(
      children: <Widget>[
        Material(
          child: ListTile(
            key: Key(languageList[0].title),
            title: Text(languageList[0].title),
            trailing: languageList[0].trailingWidget,
            onTap: () {
              Provider.of<SwitchProvider>(context, listen: false)
                  .setNewLanguage(!isLanguage);
              context.locale = Locale('en', 'US');
            },
          ),
        ),
        Divider(height: 1),
        Material(
          child: ListTile(
            key: Key(languageList[1].title),
            title: Text(languageList[1].title),
            trailing: languageList[1].trailingWidget,
            onTap: () {
              Provider.of<SwitchProvider>(context, listen: false)
                  .setNewLanguage(!isLanguage);
              context.locale = Locale('km', 'KH');
            },
          ),
        ),
        Divider(height: 1),
      ],
    );
  }
}
