import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:language_pickers/language_picker_dropdown.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:phinex/Bles/Model/requests/froms/CourseCreateFormRequest.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddEducationLangPage extends StatefulWidget {
  final String title;
  final String description;
  final String about;
  final String lang;

  const AddEducationLangPage(
      {Key key,
      this.title = '',
      this.description = '',
      this.about = '',
      this.lang})
      : super(key: key);

  @override
  _AddEducationLangPageState createState() => _AddEducationLangPageState();
}

class _AddEducationLangPageState extends State<AddEducationLangPage> {
  TextEditingController descriptionController;
  TextEditingController titleController;
  TextEditingController aboutController;

  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';
  String addressErrorMsg;

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

  List<LangCourseBean> langs = [];

  @override
  void initState() {
    super.initState();

    descriptionController = TextEditingController(text: widget.description);
    titleController = TextEditingController(text: widget.title);
    aboutController = TextEditingController(text: widget.about);

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
                title: translate(context, 'course_name'),
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
                title: AppUtils.translate(context, 'what_you_will_learn'),
                keyboardType: TextInputType.text,
                errorMessage: addressErrorMsg,
                controller: aboutController,
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
                  if (aboutController.text.isEmpty) {
                    addressErrorMsg =
                        AppLocalization.of(context).translate("required");
                  } else if (aboutController.text.length < 2) {
                    addressErrorMsg = translate(context, 'invalid_length');
                  } else {
                    addressErrorMsg = null;
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
                      addressErrorMsg == null) {
                    langs.add(
                      LangCourseBean(
                        lang: _selectedLanguage,
                        about: aboutController.text,
                        specifications: 'specifications',
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
