import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/help/terms_and_conditions_page.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/views/news/policy_page.dart';
import 'package:phinex/ui/views/settings/settings_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';

class HelpPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('help'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
        },
      ),
      body: WillPopScope(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            // option(AppLocalization.of(context).translate('faqs'), null, '', context, iconSize: 20),
            // SizedBox(
            //   height: ScreenUtil().setHeight(20),
            // ),
            // option(AppLocalization.of(context).translate('legacy'), null, '', context,),
            // SizedBox(
            //   height: ScreenUtil().setHeight(20),
            // ),
            option(AppLocalization.of(context).translate('policy'), null, '', context, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PolicyPage()));
            }),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            option(AppLocalization.of(context).translate('terms_and_conditions'), null, '', context, onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => TermsAndConditionsPage()));
            }),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            // option(AppLocalization.of(context).translate('contact_us'), null, '', context),
            // SizedBox(
            //   height: ScreenUtil().setHeight(40),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(40),
            ),
          ],
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
          return false;
        },
      ),
    );
  }
}
