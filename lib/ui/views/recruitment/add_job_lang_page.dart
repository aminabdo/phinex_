import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/languages.dart';
import 'package:phinex/Bles/Model/requests/froms/JobCreateFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddJobLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String about;
  final String requirements;
  final String lang;

  const AddJobLangPage({
    Key key,
    this.title = '',
    this.description = '',
    this.about = '',
    this.lang,
    this.requirements = '',
  }) : super(key: key);

  @override
  _AddJobLangPageState createState() => _AddJobLangPageState();
}

class _AddJobLangPageState extends State<AddJobLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController aboutController;
  TextEditingController requirementsController;

  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';
  String aboutCompanyErrorMsg;
  String requirementsErrorMsg;

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

  List<JobLang> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);
    aboutController = TextEditingController(text: widget.about);
    requirementsController = TextEditingController(text: widget.about);

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
                title: translate(context, 'job_title'),
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
                title: AppUtils.translate(context, 'about_company'),
                keyboardType: TextInputType.text,
                errorMessage: aboutCompanyErrorMsg,
                controller: aboutController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                title: AppUtils.translate(context, 'requirements'),
                keyboardType: TextInputType.text,
                errorMessage: requirementsErrorMsg,
                controller: requirementsController,
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
                  if (requirementsController.text.isEmpty) {
                    requirementsErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (requirementsController.text.length < 2) {
                    requirementsErrorMsg = translate(context, 'invalid_length');
                  } else {
                    requirementsErrorMsg = null;
                  }

                  // address
                  if (aboutController.text.isEmpty) {
                    aboutCompanyErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (aboutController.text.length < 2) {
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
                      requirementsErrorMsg == null &&
                      aboutCompanyErrorMsg == null) {
                    langs.add(
                      JobLang(
                        lang: _selectedLanguage,
                        about: aboutController.text,
                        title: titleController.text,
                        description: descriptionController.text,
                        requirements: requirementsController.text,
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
