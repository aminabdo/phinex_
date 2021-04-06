import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phinex/Bles/ApiRoutes.dart';
import 'package:phinex/main.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class SettingsLanguagePicker extends StatefulWidget {
  @override
  _SettingsLanguagePickerState createState() => _SettingsLanguagePickerState();
}

class _SettingsLanguagePickerState extends State<SettingsLanguagePicker> {
  int selectedLanguageIndex = -1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedLanguageIndex = Localizations.localeOf(context).languageCode == 'ar' ? 1 : 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalization.of(context).translate('hide'),
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            Text(
              AppLocalization.of(context).translate('select_language'),
              style: TextStyle(fontSize: 16),
            ),
            FlatButton(
              onPressed: () async {
                // english language
                if (selectedLanguageIndex == 0) {
                  MainScreen.setLocale(context, Locale('en'));
                  AppUtils.saveLanguage('en');
                  ApiRoutesUpdate.baseUrl(language: 'en');
                } else {
                  MainScreen.setLocale(context, Locale('ar'));
                  AppUtils.saveLanguage('ar');
                  ApiRoutesUpdate.baseUrl(language: 'ar');
                }

                Navigator.pop(context);
              },
              child: Text(
                AppLocalization.of(context).translate('apply'),
                style: TextStyle(color: mainColor, fontSize: 16),
              ),
            ),
          ],
        ),
        Divider(
          thickness: .7,
          color: Colors.grey[300],
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              2,
              (index) {
                return ListTile(
                  onTap: () {
                    selectedLanguageIndex = index;
                    setState(() {});
                  },
                  title: Text(index == 0 ? 'English' : 'العربية'),
                  trailing: selectedLanguageIndex == index
                      ? Icon(
                          Icons.check,
                          color: mainColor,
                        )
                      : SizedBox.shrink(),
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(
                      index == 0
                          ? 'assets/images/english_lang.jpg'
                          : 'assets/images/arabic_lang.png',
                    ),
                  ),
                );
              },
            ).toList(),
        ),
      ],
    );
  }
}
