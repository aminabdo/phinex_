
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/language_picker_dropdown.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:phinex/Bles/Model/requests/froms/ProffessionsFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddProfessionWorkshopLangPage extends StatefulWidget {
  final String commercialName;
  final String description;
  final String shortDescription;
  final String lang;

  const AddProfessionWorkshopLangPage({
    Key key,
    this.commercialName = '',
    this.description = '',
    this.lang, this.shortDescription = '',
  }) : super(key: key);

  @override
  _AddProfessionWorkshopLangPageState createState() => _AddProfessionWorkshopLangPageState();
}

class _AddProfessionWorkshopLangPageState extends State<AddProfessionWorkshopLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController addressController;

  String descriptionErrorMsg = '';
  String titlelErrorMsg = '';
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

  List<LangWorkShopBean> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.commercialName);
    addressController = TextEditingController(text: widget.shortDescription);

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
                title: translate(context, 'title'),
                controller: titleController,
                errorMessage: titlelErrorMsg,
                onChanged: (String input) {
                  if (input.isEmpty) {
                    titlelErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else {
                    titlelErrorMsg = null;
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
                errorMessage: addressErrorMsg,
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
                onChanged: (String input) {
                  if (input.isEmpty) {
                    descriptionErrorMsg = AppLocalization.of(context).translate("required");
                  } else {
                    descriptionErrorMsg = null;
                  }
                  setState(() {});
                },

              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              myButton(
                AppUtils.translate(context, 'add'),
                onTap: () {
                  // title
                  if (titleController.text.isEmpty) {
                    titlelErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (titleController.text.length < 2) {
                    titlelErrorMsg = translate(context, 'invalid_length');
                  } else {
                    titlelErrorMsg = null;
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

                  if (titlelErrorMsg == null &&
                      descriptionErrorMsg == null &&
                      addressErrorMsg == null
                  ) {
                    langs.add(
                      LangWorkShopBean(
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
