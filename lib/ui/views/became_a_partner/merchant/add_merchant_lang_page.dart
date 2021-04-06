import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/MerchantFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddMerchantLangPage extends StatefulWidget {
  final String commercialName;
  final String description;
  final String lang;

  const AddMerchantLangPage({
    Key key,
    this.commercialName = '',
    this.description = '',
    this.lang,
  }) : super(key: key);

  @override
  _AddMerchantLangPageState createState() => _AddMerchantLangPageState();
}

class _AddMerchantLangPageState extends State<AddMerchantLangPage> {
  TextEditingController descriptionController;
  TextEditingController commercialNameController;

  String descriptionErrorMsg = '';
  String commercialErrorMsg = '';

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

  List<LangMerchant> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    commercialNameController = TextEditingController(text: widget.commercialName);

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
                title: translate(context, 'commercial_name'),
                controller: commercialNameController,
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
                    commercialErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (commercialNameController.text.length < 2) {
                    commercialErrorMsg = translate(context, 'invalid_length');
                  } else {
                    commercialErrorMsg = null;
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
                      descriptionErrorMsg == null) {
                    langs.add(
                      LangMerchant(
                        lang: _selectedLanguage,
                        commercialName: commercialNameController.text,
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
