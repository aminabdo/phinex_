import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/CarRentalFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddCarRentalLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String color;
  final String lang;

  const AddCarRentalLangPage(
      {Key key,
      this.title = '',
      this.description = '',
      this.color = '',
      this.lang})
      : super(key: key);

  @override
  _AddCarRentalLangPageState createState() => _AddCarRentalLangPageState();
}

class _AddCarRentalLangPageState extends State<AddCarRentalLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController colorController;

  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';
  String colorErrorMsg;

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

  List<LangCarRentalBean> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);
    colorController = TextEditingController(text: widget.color);

    _selectedLanguage = AppUtils.language == 'en' ? 'ar' : 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppUtils.translate(context, 'add_product'),
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
                height: ScreenUtil().setHeight(20),
              ),
              MyTextFormField(
                title: translate(context, 'title'),
                errorMessage: titleErrorMsg,
                controller: titleController,
                keyboardType: TextInputType.text,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    titleErrorMsg = AppLocalization.of(context).translate("required");
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
                title: translate(context, 'color'),
                errorMessage: colorErrorMsg,
                controller: colorController,
                keyboardType: TextInputType.text,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    colorErrorMsg = AppLocalization.of(context)
                        .translate("required");
                  } else {
                    colorErrorMsg = null;
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
                errorMessage: businessActivityErrorMsg,
                controller: descriptionController,
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

                  // address
                  if (colorController.text.isEmpty) {
                    colorErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (colorController.text.length < 2) {
                    colorErrorMsg = translate(context, 'invalid_length');
                  } else {
                    colorErrorMsg = null;
                  }
                  // description
                  if (descriptionController.text.isEmpty) {
                    businessActivityErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (descriptionController.text.length < 2) {
                    businessActivityErrorMsg =
                        translate(context, 'invalid_length');
                  } else {
                    businessActivityErrorMsg = null;
                  }

                  setState(() {});

                  if (
                      businessActivityErrorMsg == null &&
                      colorErrorMsg == null) {
                    langs.add(
                      LangCarRentalBean(
                        lang: _selectedLanguage,
                        color: colorController.text,
                        title: titleController.text,
                        description: descriptionController.text,
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
