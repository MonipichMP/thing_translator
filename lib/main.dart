import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/helpers/app_theme.dart';
import 'package:thingtranslator/providers/Label_list_provider.dart';
import 'package:thingtranslator/providers/history_provider.dart';
import 'package:thingtranslator/providers/menu_index_provider.dart';
import 'package:thingtranslator/providers/switch_provider.dart';
import 'package:thingtranslator/providers/theme_provider.dart';
import 'package:thingtranslator/providers/translation_provider.dart';
import 'package:thingtranslator/screens/base_screen.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(ThemeMode.system),
        child: EasyLocalization(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('km', 'KH'),
          ],
          path: 'assets/translation',
          fallbackLocale: Locale('en', 'US'),
          startLocale: Locale('en', 'US'),
          child: MyApp(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuIndexProvider()),
        ChangeNotifierProvider(create: (_) => LabelListProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => SwitchProvider()),
      ],
      child: MaterialApp(
        title: 'Things Translator',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightTheme,
        darkTheme: AppTheme().darkTheme,
        themeMode: themeProvider.getThemeMode(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: BaseScreen(),
      ),
    );
  }
}
