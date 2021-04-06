
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/ProffessionsFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddProfessionLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String address;
  final String lang;

  const AddProfessionLangPage({
    Key key,
    this.title = '',
    this.description = '',
    this.lang, this.address = '',
  }) : super(key: key);

  @override
  _AddProfessionLangPageState createState() => _AddProfessionLangPageState();
}

class _AddProfessionLangPageState extends State<AddProfessionLangPage> {
  TextEditingController descriptionController;
  TextEditingController commercialController;
  TextEditingController shortDescriptionController;

  String descriptionErrorMsg = '';
  String commercialErrorMsg = '';
  String shortDescriptionErrorMsg = '';

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

  List<LangProffessionBean> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    commercialController = TextEditingController(text: widget.title);
    shortDescriptionController = TextEditingController(text: widget.address);

    _selectedLanguage = AppUtils.language == 'en' ? 'ar' : 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppUtils.translate(context, 'profession'),
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
                  Text(AppUtils.language == 'en' ? AppUtils.translate(context, 'arabic') : AppUtils.translate(context, 'english'),),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              MyTextFormField(
                title: translate(context, 'commercial_name'),
                controller: commercialController,
                errorMessage: commercialErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    commercialErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    commercialErrorMsg = null;
                  }
                  setState(() {});
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'short_description'),
                controller: shortDescriptionController,
                errorMessage: shortDescriptionErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    shortDescriptionErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    shortDescriptionErrorMsg = null;
                  }
                  setState(() {});
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'description'),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                errorMessage: descriptionErrorMsg,
                controller: descriptionController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              myButton(
                AppUtils.translate(context, 'add'),
                onTap: () {
                  // title
                  if (commercialController.text.isEmpty) {
                    commercialErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (commercialController.text.length < 2) {
                    commercialErrorMsg = translate(context, 'invalid_length');
                  } else {
                    commercialErrorMsg = null;
                  }

                  // address
                  if (shortDescriptionController.text.isEmpty) {
                    shortDescriptionErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (shortDescriptionController.text.length < 2) {
                    shortDescriptionErrorMsg = translate(context, 'invalid_length');
                  } else {
                    shortDescriptionErrorMsg = null;
                  }

                  // description
                  if (descriptionController.text.isEmpty) {
                    descriptionErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (descriptionController.text.length < 2) {
                    descriptionErrorMsg =
                        translate(context, 'invalid_length');
                  } else {
                    descriptionErrorMsg = null;
                  }

                  setState(() {});

                  if (commercialErrorMsg == null &&
                      descriptionErrorMsg == null &&
                      shortDescriptionErrorMsg == null
                  ) {
                    langs.add(
                      LangProffessionBean(
                        lang: _selectedLanguage,
                        commercial_name: commercialController.text,
                        description: descriptionController.text,
                        short_description: shortDescriptionController.text,
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
