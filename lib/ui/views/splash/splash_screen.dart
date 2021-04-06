import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/ui/views/home/home_page.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'initial_settings_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/app-icon.jpg'),
              Text(Localizations.localeOf(context).languageCode == 'en' ? APP_NAME : APP_NAME_AR,
                style: TextStyle(
                  fontSize: 50,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigate() async {

    AppUtils.language = await AppUtils.loadSavedLanguage();
    AppUtils.currency = await AppUtils.loadSavedCurrency();
    AppUtils.country = await AppUtils.loadSavedCountry();

    String login_date = await AppUtils.getLoginDate();

    if(login_date != null) {
      DateTime loginDate = DateTime.parse(login_date);
      DateTime dateNow = DateTime.now();

      if(dateNow.difference(loginDate).inDays >= 30) {
        AppUtils.clearUserData();
         await AppUtils.showAppDialog(context, 'need_to_login_again');
      } else {
        AppUtils.userData = await AppUtils.getUserData();
        if(AppUtils.userData != null) {
          print(AppUtils.userData.token);
          cartBloc.getUserCart(AppUtils.userData.id);
          wishlistBloc.getWishListUser(AppUtils.userData.id);
        }
      }
    }

    Future.delayed(
      Duration(seconds: 4),
      () async {
        if (AppUtils.currency == null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => InitialSettingsPage(),),);
        } else {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomePage(),), (route) => false);
        }
      },
    );
  }
}
