import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('terms_and_conditions'),
        context,
      ),
      body: SingleChildScrollView(
        child: Html(
          data: AppUtils.translate(context, 'terms_and_conditions_content'),
        ),
      ),
    );
  }
}
