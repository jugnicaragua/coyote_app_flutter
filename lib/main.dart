import 'package:coyote_app/src/bloc/provider.dart';
import 'package:coyote_app/src/bloc/settings.dart';
import 'package:coyote_app/src/pages/dashboard_page.dart';
import 'package:coyote_app/src/widgets/neumorphic_custom_app_style.dart';
import 'package:coyote_app/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  //only portrait
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('es')],
      path: 'assets/locales',
      fallbackLocale: const Locale('es'),
      useOnlyLangCode: true,
      preloaderColor:
          prefs.getBool('darkMode') == true ? Style.bgColorDark : Style.bgColor,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Settings(prefs), lazy: false),
          Provider(
            create: (_) => ProviderBloc(),
            lazy: false,
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicCustomAppStyle(
      title: 'coyote'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<Settings>().themeMode,
      theme: NeumorphicThemeData(
          defaultTextColor: Style.textColor,
          baseColor: Style.bgColor,
          accentColor: Style.primaryColor,
          variantColor: Style.primaryColor,
          intensity: 0.6,
          lightSource: LightSource.topRight,
          depth: 3,
          appBarTheme: NeumorphicAppBarThemeData(
              buttonPadding: const EdgeInsets.all(14.0),
              buttonStyle:
                  const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
              iconTheme: IconThemeData(
                color: Style.textColor,
              ),
              icons: NeumorphicAppBarIcons(
                  backIcon: Icon(FontAwesomeIcons.chevronLeft),
                  menuIcon: Icon(FontAwesomeIcons.bars)))),
      darkTheme: NeumorphicThemeData(
          defaultTextColor: Style.textColorDark,
          baseColor: Style.bgColorDark,
          accentColor: Style.primaryColor,
          variantColor: Style.primaryColor,
          intensity: 0.6,
          lightSource: LightSource.topRight,
          shadowDarkColor: Colors.black,
          shadowLightColor: Colors.grey[500],
          depth: 3,
          appBarTheme: NeumorphicAppBarThemeData(
              buttonPadding: const EdgeInsets.all(14.0),
              buttonStyle:
                  const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
              iconTheme: IconThemeData(
                color: Style.textColorDark,
              ),
              icons: NeumorphicAppBarIcons(
                  backIcon: Icon(FontAwesomeIcons.chevronLeft),
                  menuIcon: Icon(
                    FontAwesomeIcons.bars,
                  )))),
      initialRoute: 'dashboard',
      routes: {
        'dashboard': (context) => DashboardPage(),
      },
    );
  }
}
