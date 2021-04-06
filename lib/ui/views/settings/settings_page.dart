import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:phinex/Bles/ApiRoutes.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'settings_language_picker.dart';

class SettingsPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String currency;

  @override
  Widget build(BuildContext context) {
    currency = AppUtils.currency ?? 'EGP';

    return Scaffold(

      appBar: myAppBar(
        AppLocalization.of(context).translate('settings'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
          return false;
        },
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            option(
              AppLocalization.of(context).translate('language'),
              Icons.translate,
              Localizations.localeOf(context).languageCode == 'en'
                  ? 'English'
                  : 'العربية',
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
              AppLocalization.of(context).translate('currency'),
              FontAwesomeIcons.moneyBill,
              AppUtils.currency,
              context,
              onTap: () async {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  onSelect: (Currency currency) {
                    AppUtils.saveCurrency(currency.code);
                    AppUtils.currency = currency.code;
                    ApiRoutesUpdate.baseUrl(currency: currency.code);
                    setState(() {});
                  },
                );
              },
            ),
            option(
              AppLocalization.of(context).translate('country'),
              FontAwesomeIcons.globeEurope,
              AppUtils.country.toUpperCase(),
              context,
              onTap: () async {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) async {
                    AppUtils.saveCountry(country.countryCode.toLowerCase());
                    AppUtils.country = country.countryCode.toLowerCase();
                    ApiRoutesUpdate.baseUrl(country: country.countryCode.toLowerCase());
                    setState(() {});
                    generalBloc.getModelGov();
                    generalBloc.getCountries();
                  },
                );
              },
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
          ],
        ),
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
