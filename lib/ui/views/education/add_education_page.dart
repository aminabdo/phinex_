
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/froms/CourseCreateFormRequest.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/catalogue/CatalogueBloc.dart';
import 'package:phinex/Bles/bloc/course/CourseBloc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_education_lang_page.dart';

class AddEducationPage extends StatefulWidget {
  @override
  _AddEducationPageState createState() => _AddEducationPageState();
}

class _AddEducationPageState extends State<AddEducationPage> {
  String selectedCategory = 'A';
  String courseNameErrorMsg = '';
  String courseLinkErrorMsg = '';
  String experienceLevelErrorMsg = '';
  String emailErrorMsg = '';
  String websiteErrorMsg = '';
  String phoneErrorMsg = '';
  String reasonErrorMsg = '';
  String categoryErrorMsg = '';
  String descriptionErrorMsg = '';
  String coverResult = '';
  String coverErrorMsg;

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  List<String> categories = [];
  List<LangCourseBean> langs = [];
  List<String> governoratesList = [];
  List<String> cityList = [];

  // File imageFile;

  bool gotData = false;
  bool gotData2 = false;
  bool isLoading = false;

  TextEditingController courseNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // TextEditingController courseLinkController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
        child: StreamBuilder<CatalogueLandingResponse>(
          stream: catalogueBloc.landing.stream,
          builder: (context, snapshot) {
            if (catalogueBloc.loading.value) {
              return Loader();
            } else {
              if (!gotData) {
                catalogueBloc.landing.value.data.forEach((element) {
                  categories.add(element.name);
                });

                selectedCategory = categories[0];
                langs.add(
                  LangCourseBean(
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

                        var government = snapshot.data.data.governorates.firstWhere((element) => element.name == selectedGovernorate);
                        government.cities.forEach((element) {
                          cityList.add(element.name);
                        });

                        selectedCity = cityList[0];

                        var currentGovernorate =
                            snapshot.data.data.governorates.firstWhere(
                          (element) => element.name == selectedGovernorate,
                        );

                        selectedGovernorateId = currentGovernorate.id.toString();

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
                            MyTextFormField(
                              title: AppUtils.translate(context, 'course_name'),
                              controller: courseNameController,
                              errorMessage: courseNameErrorMsg,
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
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            MyTextFormField(
                              title: AppUtils.translate(context, 'description'),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              errorMessage: descriptionErrorMsg,
                              controller: descriptionController,
                            ),
                            MyTextFormField(
                              title: AppUtils.translate(
                                  context, 'what_you_will_learn'),
                              controller: reasonController,
                              maxLines: 4,
                              errorMessage: reasonErrorMsg,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
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
                                    AppUtils.hideKeyboard(context);
                                    selectedGovernorate = newValue;
                                    var currentGovernorate = snapshot
                                        .data.data.governorates
                                        .firstWhere(
                                      (element) =>
                                          element.name == selectedGovernorate,
                                    );

                                    selectedGovernorateId = currentGovernorate.id.toString();

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
                                    AppUtils.hideKeyboard(context);
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
                              style: TextStyle(color: Colors.red),
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
                                            List<LangCourseBean> addedLangs =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    AddEducationLangPage(
                                                  title: langs[index].title,
                                                  about: langs[index].about,
                                                  lang: langs[index].lang,
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
                                  onTap: langs.length >= 2 ? null : () async {
                                    List<LangCourseBean> addedLangs =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddEducationLangPage(),
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
                                        translate(context, 'add_another_language'),
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

    // // image
    // if (imageFile == null) {
    //   coverErrorMsg = translate(context, 'required');
    // } else {
    //   coverErrorMsg = null;
    // }

    // title
    if (courseNameController.text.isEmpty) {
      courseNameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (courseNameController.text.length < 2) {
      courseNameErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      courseNameErrorMsg = null;
    }

    // what you will lean
    if (reasonController.text.isEmpty) {
      reasonErrorMsg = AppLocalization.of(context).translate("required");
    } else if (reasonController.text.length < 2) {
      reasonErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      reasonErrorMsg = null;
    }

    if (emailController.text.isNotEmpty) {
      print(emailController.text);
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
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else if (descriptionController.text.length < 2) {
      descriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      descriptionErrorMsg = null;
    }

    setState(() {});

    if (descriptionErrorMsg == null &&
        reasonErrorMsg == null &&
        phoneErrorMsg == null &&
        // courseLinkErrorMsg == null &&
        // websiteErrorMsg == null &&
        emailErrorMsg == null &&
        courseNameErrorMsg == null) {

      langs[0].title = courseNameController.text;
      langs[0].about = reasonController.text;
      langs[0].description = descriptionController.text;
      langs[0].specifications = 'specifications.text';

      isLoading = true;
      setState(() {});

      String categoryId;
      catalogueBloc.landing.value.data.forEach((element) {
        if (element.name == selectedCategory) {
          categoryId = element.id.toString();
        }
      });

      var request = CourseCreateFormRequest(
        lang: langs,
        email: emailController.text,
        categoryId: categoryId,
        cityId: selectedCityId,
        countryId: AppUtils.getCountryId(),
        governorateId: selectedGovernorateId,
        instructorId: AppUtils.userData.id.toString(),
        mobile: phoneController.text,
      );

      var course = await courseBloc.addCourse(request);
      if (course != null) {
        AppUtils.showToast(msg: AppUtils.translate(context, 'done'), bgColor: mainColor);
        Navigator.pop(context);
      } else {
        AppUtils.showToast(msg: AppUtils.translate(context, 'error'), bgColor: mainColor);
      }

      isLoading = false;
      setState(() {});
    }
  }
}
