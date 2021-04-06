import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/froms/JobCreateFormRequest.dart';
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
import 'package:path/path.dart';
import 'add_job_lang_page.dart';

class AddRecruitmentPage extends StatefulWidget {
  @override
  _AddRecruitmentPageState createState() => _AddRecruitmentPageState();
}

class _AddRecruitmentPageState extends State<AddRecruitmentPage> {
  String selectedCategory = 'A';
  String jobTitleErrorMsg = '';
  String requirementsErrorMsg = '';
  String emailErrorMsg = '';
  String websiteErrorMsg = '';
  String phoneErrorMsg = '';
  String cityErrorMsg = '';
  String governmentErrorMsg = '';
  String categoryErrorMsg = '';
  String jobDescriptionErrorMsg = '';
  String aboutCompanyErrorMsg = '';
  String addressErrorMsg = '';

  List<String> categories = [];

  String selectedEmpType = '';
  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  File coverImage;

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> empTypeList = [];
  List<String> careerLevelList = [];
  List<JobLang> langs = [];

  String coverImageResult;
  String coverImageErrorMsg;

  String selectedCareerType;

  bool gotData = false;
  bool gotData2 = false;
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String getCareerLevelType() {
    if (selectedCareerType == careerLevelList[0]) {
      return 'Manager';
    } else if (selectedCareerType == careerLevelList[1]) {
      return 'Experienced';
    } else {
      return 'EntryLevel';
    }
  }

  @override
  Widget build(BuildContext context) {
    empTypeList = [
      AppUtils.translate(context, 'full_time'),
      AppUtils.translate(context, 'part_time'),
    ];

    careerLevelList = [
      AppUtils.translate(context, 'manager'),
      AppUtils.translate(context, 'experienced'),
      AppUtils.translate(context, 'entry_level'),
    ];


    print(jobBloc.cat.value.data[0].id);

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'add_new_job'),
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
                selectedEmpType = empTypeList[0];
                selectedCareerType = careerLevelList[0];

                langs.add(
                  JobLang(
                    lang: AppUtils.language,
                  ),
                );

                gotData = true;
              }
              return StreamBuilder<GeneralModelGovResponse>(
                stream: generalBloc.generalGovModel.stream,
                builder: (context, snapshot) {
                  if (generalBloc.loading.value) {
                    return Loader();
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (!gotData2) {
                        snapshot.data.data.governorates.forEach((element) {
                          governoratesList.add(element.name);
                        });

                        selectedGovernorate = governoratesList[0];

                        var government = snapshot.data.data.governorates
                            .firstWhere((element) =>
                                element.name == selectedGovernorate);
                        government.cities.forEach((element) {
                          cityList.add(element.name);
                        });

                        selectedCity = cityList[0];

                        var currentGovernorate =
                            snapshot.data.data.governorates.firstWhere(
                          (element) => element.name == selectedGovernorate,
                        );

                        selectedGovernorateId =
                            currentGovernorate.id.toString();

                        currentGovernorate.cities.forEach(
                          (element) {
                            if (element.name == selectedCity) {
                              selectedCityId = element.id.toString();
                            }
                          },
                        );

                        gotData2 = true;
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
                            Text(
                              AppLocalization.of(context).translate('emp_type'),
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
                                  value: selectedEmpType,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  items: empTypeList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    selectedEmpType = newValue;
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
                            Text(
                              AppLocalization.of(context)
                                  .translate('career_level'),
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
                                  value: selectedCareerType,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  items: careerLevelList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    selectedCareerType = newValue;
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
                              title: translate(context, 'job_title'),
                              controller: titleController,
                              errorMessage: jobTitleErrorMsg,
                            ),
                            MyUploadImageButton(
                              result: coverImageResult,
                              title: AppUtils.translate(context, 'cover_image'),
                              onTap: () async {
                                if (await AppUtils.askPhotosPermission()) {
                                  var images = await AppUtils.getImage(1);
                                  if (images != null) {
                                    var path = await FlutterAbsolutePath
                                        .getAbsolutePath(
                                      images[0].identifier,
                                    );

                                    coverImage = File(path);
                                    String name = basename(path);
                                    coverImageResult = name;
                                    setState(() {});
                                  }
                                }
                              },
                            ),
                            Text(
                              coverImageErrorMsg ?? '',
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(25),
                            ),
                            MyTextFormField(
                              title: translate(context, 'requirements'),
                              controller: requirementsController,
                              errorMessage: requirementsErrorMsg,
                              maxLines: 6,
                            ),
                            MyTextFormField(
                              title: translate(context, 'about_company'),
                              controller: aboutCompanyController,
                              errorMessage: aboutCompanyErrorMsg,
                              maxLines: 6,
                            ),
                            MyTextFormField(
                              title: translate(context, 'job_description'),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              errorMessage: jobDescriptionErrorMsg,
                              controller: jobDescriptionController,
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(10),
                            ),
                            // MyTextFormField(
                            //   title: AppLocalization.of(context)
                            //       .translate('website'),
                            //   controller: websiteController,
                            //   errorMessage: websiteErrorMsg,
                            // ),
                            MyTextFormField(
                              title: AppLocalization.of(context)
                                  .translate('email'),
                              errorMessage: emailErrorMsg,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            MyTextFormField(
                              title: AppLocalization.of(context)
                                  .translate('mobile_number'),
                              errorMessage: phoneErrorMsg,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                            MyTextFormField(
                              title: AppLocalization.of(context)
                                  .translate('address'),
                              errorMessage: addressErrorMsg,
                              controller: addressController,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            Text(
                              translate(context, 'government'),
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
                                  value: selectedGovernorate,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  items: governoratesList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    selectedGovernorate = newValue;
                                    var currentGovernorate = snapshot
                                        .data.data.governorates
                                        .firstWhere(
                                      (element) =>
                                          element.name == selectedGovernorate,
                                    );

                                    selectedGovernorateId =
                                        currentGovernorate.id.toString();

                                    cityList.clear();
                                    currentGovernorate.cities
                                        .forEach((element) {
                                      cityList.add(element.name);
                                    });

                                    selectedCity = cityList[0];
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              translate(context, 'city'),
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
                                  value: selectedCity,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  items: cityList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    selectedCity = newValue;
                                    var currentGovernorate = snapshot
                                        .data.data.governorates
                                        .firstWhere(
                                      (element) =>
                                          element.name == selectedGovernorate,
                                    );

                                    currentGovernorate.cities
                                        .forEach((element) {
                                      if (element.name == selectedCity) {
                                        selectedCityId = element.id.toString();
                                      }
                                    });

                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 60,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (index == 0) return;
                                            List<JobLang> addedLangs =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => AddJobLangPage(
                                                  title: langs[index].title,
                                                  about: langs[index].about,
                                                  lang: langs[index].lang,
                                                  requirements:
                                                      langs[index].requirements,
                                                  description:
                                                      langs[index].description,
                                                ),
                                              ),
                                            );
                                            if (addedLangs != null &&
                                                addedLangs.isNotEmpty) {
                                              langs.addAll(addedLangs);
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: mainColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                langs[index].lang,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: langs.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: langs.length >= 2
                                      ? null
                                      : () async {
                                          List<JobLang> addedLangs =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AddJobLangPage(),
                                            ),
                                          );
                                          if (addedLangs != null &&
                                              addedLangs.isNotEmpty) {
                                            langs.addAll(addedLangs);
                                            setState(() {});
                                          }
                                        },
                                  child: Container(
                                    height: 60,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: mainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        translate(
                                            context, 'add_another_language'),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            myButton(
                              translate(context, 'post_job'),
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
    if (coverImage == null) {
      coverImageErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      coverImageErrorMsg = null;
    }

    // title
    if (titleController.text.isEmpty) {
      jobTitleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      jobTitleErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      jobTitleErrorMsg = null;
    }

    // requirements
    if (requirementsController.text.isEmpty) {
      requirementsErrorMsg = AppLocalization.of(context).translate("required");
    } else if (requirementsController.text.length < 2) {
      requirementsErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      requirementsErrorMsg = null;
    }

    // address
    if (addressController.text.isEmpty) {
      addressErrorMsg = AppLocalization.of(context).translate("required");
    } else if (addressController.text.length < 2) {
      addressErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      addressErrorMsg = null;
    }

    // email
    if (emailController.text.isEmpty) {
      emailErrorMsg = translate(context, 'required');
    } else if (!PatternUtils.emailIsValid(email: emailController.text)) {
      emailErrorMsg = translate(context, 'enter_valid_email');
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
    if (jobDescriptionController.text.isEmpty) {
      jobDescriptionErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (jobDescriptionController.text.length < 2) {
      jobDescriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      jobDescriptionErrorMsg = null;
    }

    // about company
    if (aboutCompanyController.text.isEmpty) {
      aboutCompanyErrorMsg = AppLocalization.of(context).translate("required");
    } else if (aboutCompanyController.text.length < 2) {
      aboutCompanyErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      aboutCompanyErrorMsg = null;
    }

    setState(() {});

    if (jobDescriptionErrorMsg == null &&
        phoneErrorMsg == null &&
        aboutCompanyErrorMsg == null &&
        emailErrorMsg == null &&
        requirementsErrorMsg == null &&
        jobTitleErrorMsg == null &&
        addressErrorMsg == null &&
        coverImageErrorMsg == null) {

      isLoading = true;
      setState(() {});

      langs[0].title = titleController.text;
      langs[0].about = aboutCompanyController.text;
      langs[0].description = jobDescriptionController.text;
      langs[0].requirements = requirementsController.text;

      var request = JobCreateFormRequest(
        mobile: phoneController.text,
        governorateId: selectedGovernorateId,
        countryId: AppUtils.getCountryId(),
        cityId: selectedCityId,
        categoryId: jobBloc.cat.value.data.firstWhere((element) => element.name == selectedCategory).id.toString(),
        email: emailController.text,
        image: coverImage,
        address: addressController.text,
        type: selectedEmpType == empTypeList[0] ? 'FullTime' : 'PartTime',
        lang: langs,
        careerLevel: getCareerLevelType(),
      );

      print(request.toJson());

      var job = await jobBloc.addJob(request);
      if (job != null) {
        isLoading = false;
        setState(() {});
        AppUtils.showToast(msg: AppUtils.translate(context, 'done'), bgColor: mainColor);

        Navigator.pop(context);
      }
    }
  }
}
