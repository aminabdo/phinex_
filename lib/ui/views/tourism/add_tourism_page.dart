import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobsByCatResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddTourismPage extends StatefulWidget {
  @override
  _AddTourismPageState createState() => _AddTourismPageState();
}

class _AddTourismPageState extends State<AddTourismPage> {
  String selectedCategory = 'A';
  String courseNameErrorMsg = '';
  String courseLinkErrorMsg = '';
  String experienceLevelErrorMsg = '';
  String emailErrorMsg = '';
  String websiteErrorMsg = '';
  String phoneErrorMsg = '';
  String reasonErrorMsg = '';
  String categoryErrorMsg = '';
  String jobDescriptionErrorMsg = '';
  String coverResult = '';
  String coverErrorMsg;

  List<String> categories = [];
  File imageFile;

  bool gotData = false;
  bool isLoading = false;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController experienceLevelController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController courseLinkController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController businessActivityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        translate(context, 'Add Course'),
        context,
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loader(),
        color: Colors.white,
        opacity: .5,
        child: StreamBuilder<JobsByCatResponse>(
          stream: jobBloc.landing.stream,
          builder: (context, snapshot) {
            if (jobBloc.loading.value) {
              return Loader();
            } else {
              if (!gotData) {
                jobBloc.cat.value.data.forEach((element) {
                  categories.add(element.name);
                });

                selectedCategory = categories[0];

                gotData = true;
              }
              return StreamBuilder<GeneralModelGovResponse>(
                stream: generalBloc.generalGovModel.stream,
                builder: (context, snapshot) {
                  if (generalBloc.loading.value) {
                    return Loader();
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (!gotData) {
                        gotData = true;
                      }
                    }
                    return Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        physics: bouncingScrollPhysics,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),
                            Text(
                              AppLocalization.of(context).translate('category'),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(12),
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffEEEEEE),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCategory,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  items: categories.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    selectedCategory = newValue;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Text(
                              categoryErrorMsg,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            MyTextFormField(
                              title: 'Course Name',
                              controller: courseNameController,
                              errorMessage: courseNameErrorMsg,
                            ),
                            MyTextFormField(
                              title: 'Course Link',
                              controller: courseLinkController,
                              errorMessage: courseLinkErrorMsg,
                            ),
                            MyUploadImageButton(
                              title: 'Course Cover Image',
                              onTap: () async {
                                List<Asset> resultList =
                                    await AppUtils.getImage(10);
                                if (resultList != null) {
                                  String path =
                                      await FlutterAbsolutePath.getAbsolutePath(
                                          resultList[0].identifier);
                                  imageFile = File(path);

                                  coverResult = basename(path);
                                  setState(() {});
                                }
                              },
                              result: coverResult,
                            ),
                            Text(
                              coverErrorMsg ?? '',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            MyTextFormField(
                              title: AppLocalization.of(context)
                                  .translate('email'),
                              errorMessage: emailErrorMsg,
                              controller: emailController,
                            ),
                            MyTextFormField(
                              title: AppLocalization.of(context)
                                  .translate('mobile_number'),
                              errorMessage: phoneErrorMsg,
                              controller: phoneController,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            MyTextFormField(
                              title: 'Job Description',
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              errorMessage: jobDescriptionErrorMsg,
                              controller: businessActivityController,
                            ),
                            MyTextFormField(
                              title: 'What will the student learn ?',
                              controller: reasonController,
                              maxLines: 4,
                              errorMessage: reasonErrorMsg,
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(10),
                            ),
                            myButton(
                              'Add Course',
                              btnColor: mainColor,
                              onTap: () {
                                validateAndCreateNewJob(context);
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(20),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  void validateAndCreateNewJob(BuildContext context) async {
    AppUtils.hideKeyboard(context);

    // image
    if (imageFile == null) {
      coverErrorMsg = translate(context, 'required');
    } else {
      coverErrorMsg = null;
    }

    // title
    if (courseNameController.text.isEmpty) {
      courseNameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (courseNameController.text.length < 2) {
      courseNameErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      courseNameErrorMsg = null;
    }

    // Employment Type
    if (courseLinkController.text.isEmpty) {
      courseLinkErrorMsg = AppLocalization.of(context).translate("required");
    } else if (courseLinkController.text.length < 2) {
      courseLinkErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      courseLinkErrorMsg = null;
    }

    // experience Level
    if (experienceLevelController.text.isEmpty) {
      experienceLevelErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (experienceLevelController.text.length < 2) {
      experienceLevelErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      experienceLevelErrorMsg = null;
    }

    if (websiteController.text.isNotEmpty) {
      if (!PatternUtils.urlIsValid(url: websiteController.text)) {
        websiteErrorMsg = translate(context, 'enter_valid_url');
      } else {
        websiteErrorMsg = null;
      }
    } else {
      websiteErrorMsg = null;
    }

    if (courseLinkController.text.isEmpty) {
      courseLinkErrorMsg = AppLocalization.of(context).translate("required");
    } else if (!PatternUtils.urlIsValid(url: websiteController.text)) {
      websiteErrorMsg = translate(context, 'enter_valid_url');
    } else {
      websiteErrorMsg = null;
    }

    if (emailController.text.isNotEmpty) {
      if (!PatternUtils.emailIsValid(email: emailController.text)) {
        emailErrorMsg = translate(context, 'enter_valid_email');
      } else {
        emailErrorMsg = null;
      }
    } else {
      emailErrorMsg = null;
    }

    // mobile number
    if (phoneController.text.isEmpty) {
      phoneErrorMsg = AppLocalization.of(context).translate("required");
    } else if (phoneController.text.length < 2) {
      phoneErrorMsg =
          AppLocalization.of(context).translate("mobile_length_not_valid");
    } else {
      phoneErrorMsg = null;
    }

    // job description
    if (businessActivityController.text.isEmpty) {
      jobDescriptionErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (businessActivityController.text.length < 2) {
      jobDescriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      jobDescriptionErrorMsg = null;
    }

    setState(() {});

    if (jobDescriptionErrorMsg == null &&
        courseLinkErrorMsg == null &&
        phoneErrorMsg == null &&
        courseLinkErrorMsg == null &&
        websiteErrorMsg == null &&
        emailErrorMsg == null &&
        courseLinkErrorMsg == null &&
        courseNameErrorMsg == null) {
      isLoading = true;
    }
  }
}
