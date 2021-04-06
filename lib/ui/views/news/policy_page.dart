
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('policy'),
        context,
      ),
      body: SingleChildScrollView(
        child: Html(
          data: AppUtils.translate(context, 'policy_content'),
        ),
      ),
    );
  }
}
