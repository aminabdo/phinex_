
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/language_picker_dropdown.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:phinex/Bles/Model/requests/froms/PharmaCistFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddPharmacyLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String address;
  final String lang;

  const AddPharmacyLangPage({
    Key key,
    this.title = '',
    this.description = '',
    this.lang, this.address = '',
  }) : super(key: key);

  @override
  _AddPharmacyLangPageState createState() => _AddPharmacyLangPageState();
}

class _AddPharmacyLangPageState extends State<AddPharmacyLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController addressController;

  String descriptionErrorMsg = '';
  String commercialErrorMsg = '';
  String addressErrorMsg = '';

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

  List<LangPharmacist> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);
    addressController = TextEditingController(text: widget.address);

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
                height: ScreenUtil().setHeight(30),
              ),
              MyTextFormField(
                title: translate(context, 'title'),
                controller: titleController,
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
                title: translate(context, 'address'),
                controller: addressController,
                errorMessage: commercialErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    addressErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    addressErrorMsg = null;
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
                  if (titleController.text.isEmpty) {
                    commercialErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (titleController.text.length < 2) {
                    commercialErrorMsg = translate(context, 'invalid_length');
                  } else {
                    commercialErrorMsg = null;
                  }

                  // address
                  if (addressController.text.isEmpty) {
                    addressErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (addressController.text.length < 2) {
                    addressErrorMsg = translate(context, 'invalid_length');
                  } else {
                    addressErrorMsg = null;
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
                      addressErrorMsg == null
                  ) {
                    langs.add(
                      LangPharmacist(
                        lang: _selectedLanguage,
                        title: titleController.text,
                        description: descriptionController.text,
                        address: addressController.text,
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
