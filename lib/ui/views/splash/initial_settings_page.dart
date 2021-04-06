import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phinex/Bles/ApiRoutes.dart';
import 'package:phinex/ui/views/home/home_page.dart';
import 'package:phinex/ui/views/settings/settings_language_picker.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';


class InitialSettingsPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _InitialSettingsPageState createState() => _InitialSettingsPageState();
}

class _InitialSettingsPageState extends State<InitialSettingsPage> {
  String currency;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(
      [
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    currency = AppUtils.currency ?? '';

    ApiRoutesUpdate.baseUrl(language: Localizations.localeOf(context).languageCode);

    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('settings'),
        context,
       withLeading: false
      ),
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          option(
            AppLocalization.of(context).translate('language'),
            Icons.translate,
            Localizations.localeOf(context).languageCode == 'en' ? 'English' : 'العربية',
            context,
            iconSize: 20,
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                context: context,
                builder: (context) {
                  return SettingsLanguagePicker();
                },
              );
            },
          ),
          option(
            AppLocalization.of(context).translate('country'),
            FontAwesomeIcons.globeEurope,
            AppUtils.country ?? '',
            context,
            onTap: () async {
              showCountryPicker(
                context: context,
                showPhoneCode: false,
                onSelect: (Country country) async {
                  AppUtils.saveCountry(country.countryCode.toLowerCase());
                  AppUtils.country = country.countryCode.toLowerCase();

                  setState(() {});
                },
              );
            },
          ),
          option(
            AppLocalization.of(context).translate('currency'),
            FontAwesomeIcons.moneyBill,
            AppUtils.currency ?? '',
            context,
            onTap: () async {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                onSelect: (Currency currency) async {
                  await AppUtils.saveCurrency(currency.code);
                  AppUtils.currency = currency.code;
                  setState(() {});
                },
              );
            },
          ),
          SizedBox(
            height: ScreenUtil().setHeight(40),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: myButton(AppUtils.translate(context, 'start'), onTap: () async {
              if(AppUtils.country == null) {
                AppUtils.showToast(msg: AppUtils.translate(context, 'select_country'));
              } else if (AppUtils.currency == null) {
                AppUtils.showToast(msg: AppUtils.translate(context, 'select_currency1'));
              } else {
                if(Localizations.localeOf(context).languageCode == 'en') {
                  await AppUtils.saveLanguage('en');
                } else {
                  await AppUtils.saveLanguage('ar');
                }

                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
              }
            }),
          ),
        ],
      ),
    );
  }
}

Widget option(String title, IconData icon, String result, BuildContext context, {Function onTap, double iconSize}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(12),
        vertical: ScreenUtil().setHeight(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: .3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon == null
                  ? SizedBox.shrink()
                  : Icon(
                icon,
                size: iconSize ?? 18,
                color: deepBlueColor,
              ),
              icon == null
                  ? SizedBox.shrink()
                  : SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: icon == null ? null : FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                result,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              Icon(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? Icons.arrow_back_ios_outlined
                    : Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Colors.grey[400],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
