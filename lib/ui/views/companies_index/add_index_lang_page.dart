import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateCalalougeFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddCatalougeLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String businessActivity;
  final String descriptionActivity;
  final String address;
  final String lang;

  const AddCatalougeLangPage({
    Key key,
    this.title = '',
    this.description = '',
    this.businessActivity = '',
    this.lang,
    this.descriptionActivity = '', this.address = '',
  }) : super(key: key);

  @override
  _AddCatalougeLangPageState createState() => _AddCatalougeLangPageState();
}

class _AddCatalougeLangPageState extends State<AddCatalougeLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController addressController;
  TextEditingController businessActivityController;
  TextEditingController descriptionActivityController;

  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';
  String aboutCompanyErrorMsg;
  String descriptionActivityErrorMsg;
  String addressErrorMsg;

  String _selectedLanguage;

  List<LangCatalouge> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);
    businessActivityController = TextEditingController(text: widget.businessActivity);
    addressController = TextEditingController(text: widget.address);
    descriptionActivityController = TextEditingController(text: widget.businessActivity);

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
                errorMessage: titleErrorMsg,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: translate(context, 'address'),
                controller: addressController,
                errorMessage: addressErrorMsg,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: AppUtils.translate(context, 'business_activity'),
                keyboardType: TextInputType.text,
                maxLines: 5,
                errorMessage: businessActivityErrorMsg,
                controller: businessActivityController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: AppUtils.translate(context, 'business_description'),
                keyboardType: TextInputType.text,
                errorMessage: descriptionActivityErrorMsg,
                maxLines: 5,
                controller: descriptionActivityController,
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

                  // requirements
                  if (descriptionActivityController.text.isEmpty) {
                    descriptionActivityErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (descriptionActivityController.text.length < 2) {
                    descriptionActivityErrorMsg = translate(context, 'invalid_length');
                  } else {
                    descriptionActivityErrorMsg = null;
                  }

                  // address
                  if (businessActivityController.text.isEmpty) {
                    aboutCompanyErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (businessActivityController.text.length < 2) {
                    aboutCompanyErrorMsg = translate(context, 'invalid_length');
                  } else {
                    aboutCompanyErrorMsg = null;
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

                  if (titleErrorMsg == null &&
                      businessActivityErrorMsg == null &&
                      descriptionActivityErrorMsg == null &&
                      aboutCompanyErrorMsg == null) {
                    langs.add(
                      LangCatalouge(
                        lang: _selectedLanguage,
                        business_activity: businessActivityController.text,
                        title: titleController.text,
                        description: descriptionController.text,
                        business_description: descriptionActivityController.text,
                        address: addressController.text
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
