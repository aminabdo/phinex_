
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/language_picker_dropdown.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:phinex/Bles/Model/requests/froms/DoctorFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class DoctorPersonalLangPage extends StatefulWidget {

  final String commercialName;
  final String description;
  final String shortDescription;
  final String lang;

  const DoctorPersonalLangPage({Key key, this.commercialName = '', this.description = '', this.shortDescription = '', this.lang}) : super(key: key);

  @override
  _DoctorPersonalLangPageState createState() => _DoctorPersonalLangPageState();
}

class _DoctorPersonalLangPageState extends State<DoctorPersonalLangPage> {
  TextEditingController descriptionController;
  TextEditingController commercialNameController;
  TextEditingController shortDescriptionController;

  String descriptionErrorMsg = '';
  String commercialNameErrorMsg = '';
  String shortDescriptionErrorMsg;

  Language _selectedLanguage;

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

  List<LangDoctor> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    commercialNameController = TextEditingController(text: widget.commercialName);
    shortDescriptionController = TextEditingController(text: widget.shortDescription);

    _selectedLanguage = LanguagePickerUtils.getLanguageByIsoCode(widget.lang ?? AppUtils.language);
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffEEEEEE),
                ),
                height: 45,
                child: LanguagePickerDropdown(
                  initialValue: _selectedLanguage.isoCode,
                  itemBuilder: _buildDropdownItem,
                  onValuePicked: (Language language) {
                    _selectedLanguage = language;
                    print(_selectedLanguage.name);
                    print(_selectedLanguage.isoCode);
                  },
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              MyTextFormField(
                title: translate(context, 'commercial_name'),
                controller: commercialNameController,
                errorMessage: commercialNameErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    commercialNameErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    commercialNameErrorMsg = null;
                  }
                  setState(() {});
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'short_description'),
                keyboardType: TextInputType.text,
                errorMessage: shortDescriptionErrorMsg,
                controller: shortDescriptionController,
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
                  if (commercialNameController.text.isEmpty) {
                    commercialNameErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (commercialNameController.text.length < 2) {
                    commercialNameErrorMsg = translate(context, 'invalid_length');
                  } else {
                    commercialNameErrorMsg = null;
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

                  if (commercialNameErrorMsg == null &&
                      descriptionErrorMsg == null &&
                      shortDescriptionErrorMsg == null) {
                    langs.add(
                      LangDoctor(
                        lang: _selectedLanguage.isoCode,
                        short_description: shortDescriptionController.text,
                        commercial_name: commercialNameController.text,
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
