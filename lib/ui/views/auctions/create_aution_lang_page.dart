import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateAuctionFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class CreateAuctionLangPage extends StatefulWidget {

  final String title;
  final String description;
  final String lang;

  const CreateAuctionLangPage({Key key, this.title = '', this.description = '', this.lang}) : super(key: key);

  @override
  _CreateAuctionLangPageState createState() => _CreateAuctionLangPageState();
}

class _CreateAuctionLangPageState extends State<CreateAuctionLangPage> {
  TextEditingController businessActivityController;
  TextEditingController titleController;

  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';

  String _selectedLanguage;

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  List<LangAuction> langs = [];

  @override
  void initState() {
    super.initState();

    businessActivityController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);

    _selectedLanguage = AppUtils.language == 'en' ? 'ar' : 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppUtils.translate(context, 'add_auction'),
        context,
      ),
      body: SingleChildScrollView(
        physics: bouncingScrollPhysics,
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(AppUtils.translate(context, 'language')),
                  Text(' : '),
                  Text(AppUtils.language == 'en' ? AppUtils.translate(context, 'english') : AppUtils.translate(context, 'arabic'),),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              MyTextFormField(
                title: translate(context, 'title0'),
                controller: titleController,
                errorMessage: titleErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    titleErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    titleErrorMsg = null;
                  }
                  setState(() {});
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'business_activity'),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                errorMessage: businessActivityErrorMsg,
                controller: businessActivityController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              myButton(
                AppUtils.translate(context, 'add'),
                onTap: () {
                  // title
                  if (titleController.text.isEmpty) {
                    titleErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (titleController.text.length < 2) {
                    titleErrorMsg = translate(context, 'invalid_length');
                  } else {
                    titleErrorMsg = null;
                  }

                  // description
                  if (businessActivityController.text.isEmpty) {
                    businessActivityErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (businessActivityController.text.length < 2) {
                    businessActivityErrorMsg =
                        translate(context, 'invalid_length');
                  } else {
                    businessActivityErrorMsg = null;
                  }

                  setState(() {});

                  if (titleErrorMsg == null &&
                      businessActivityErrorMsg == null) {
                    langs.add(
                      LangAuction(
                        lang: _selectedLanguage,
                        title: titleController.text,
                        description: businessActivityController.text,
                      ),
                    );

                    Navigator.pop(context, langs);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
