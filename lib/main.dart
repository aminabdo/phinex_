import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/doctor_provider.dart';
import 'providers/page_provider.dart';
import 'ui/views/chats/firends/friends_provider.dart';
import 'ui/views/splash/splash_screen.dart';
import 'utils/app_localization.dart';
import 'utils/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  services.SystemChrome.setPreferredOrientations([
    services.DeviceOrientation.portraitUp,
    services.DeviceOrientation.portraitDown,
  ]);

  runApp(
    MainScreen(languageCode: (await SharedPreferences.getInstance()).getString(SharedPreferencesKeys.lang_code) ?? 'en')
  );
}

class MainScreen extends StatefulWidget {

  final String languageCode;

  const MainScreen({Key key, this.languageCode}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MainScreenState state = context.findAncestorStateOfType<_MainScreenState>();

    state.setState(() {
      state._locale = locale;
    });
  }

  @override
  _MainScreenState createState() => new _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Locale _locale;

  @override
  void initState() {
    super.initState();

    setLanguage();
  }

  setLanguage() async {
    _locale = Locale(widget.languageCode);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FriendsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APP_NAME,
        locale: _locale,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('ar'), // Arabic
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          primaryColor: mainColor,
          accentColor: deepBlueColor,
          fontFamily: 'Cairo',
        ),
        home: Builder(
          builder: (context) {
            ScreenUtil.init(
              BoxConstraints(
                maxWidth: 450,
                maxHeight: 690,
              ),
              designSize: MediaQuery.of(context).size,
              allowFontScaling: true,
            );
            return Directionality(
              textDirection:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,

              child: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
