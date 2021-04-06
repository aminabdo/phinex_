
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/DoctorFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddClinicLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String lang;
  final String address;

  const AddClinicLangPage({
    Key key,
    this.title = '',
    this.description = '',
    this.address, this.lang
  }) : super(key: key);

  @override
  _AddRealStateLangPageState createState() => _AddRealStateLangPageState();
}

class _AddRealStateLangPageState extends State<AddClinicLangPage> {
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController addressController;

  String descriptionErrorMsg = '';
  String titleErrorMsg = '';
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

  List<LangClinic> langs = [];

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    addressController = TextEditingController(text: widget.address);

    _selectedLanguage = widget.lang ?? AppUtils.language == 'en' ? 'ar' : 'en';
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
                title: translate(context, 'description'),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                errorMessage: descriptionErrorMsg,
                controller: descriptionController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'address'),
                errorMessage: addressErrorMsg,
                controller: addressController,
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
                  if (descriptionController.text.isEmpty) {
                    descriptionErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (titleController.text.length < 2) {
                    descriptionErrorMsg =
                        translate(context, 'invalid_length');
                  } else {
                    descriptionErrorMsg = null;
                  }

                  // address
                  if (addressController.text.isEmpty) {
                    addressErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (addressController.text.length < 2) {
                    addressErrorMsg =
                        translate(context, 'invalid_length');
                  } else {
                    addressErrorMsg = null;
                  }

                  setState(() {});

                  if (titleErrorMsg == null &&
                      descriptionErrorMsg == null && addressErrorMsg == null) {
                    langs.add(
                      LangClinic  (
                        lang: _selectedLanguage,
                        title: descriptionController.text,
                        description: titleController.text,
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
