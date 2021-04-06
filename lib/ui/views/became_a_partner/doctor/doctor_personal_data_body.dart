import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/froms/DoctorFormRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorDetailsCreateResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/DoctorBloc.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'doctor_personal_lang_page.dart';
import 'doctor_registeration_page.dart';

class DoctorPersonalDataBody extends StatefulWidget {
  @override
  _DoctorPersonalDataBodyState createState() => _DoctorPersonalDataBodyState();
}

class _DoctorPersonalDataBodyState extends State<DoctorPersonalDataBody> {
  File imageFile;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String selectedDegree = '';
  String selectedHomeVisit = '';
  String selectedSpeciality = '';

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> specialityList = [];

  List<LangDoctor> langs = [];

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  List<String> homeVisitList ;

  List<String> degreeList ;

  bool gotData = false;

  String imageErrorMsg;
  String firstNameErrorMsg;
  String lastNameErrorMsg;
  String phoneErrorMsg;
  String emailErrorMsg;
  String websiteErrorMsg;
  String commerciaNameErrorMsg;
  String descriptionErrorMsg;
  String shortDescriptionErrorMsg;

  @override
  Widget build(BuildContext context) {
    homeVisitList = [translate(context, 'available'), translate(context, 'not_available')];
    degreeList = [
      translate(context, 'specialist'),
      translate(context, 'consultant'),
      translate(context, 'lecturer'),
      translate(context, 'associate_professor'),
      translate(context, 'professor'),
    ];

    return StreamBuilder<DoctorDetailsCreateResponse>(
      stream: doctorBloc.doctorCreateDetails.stream,
      builder: (context, snapshot) {
        if (doctorBloc.loading.value) {
          return Loader();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            if (!gotData) {

              langs.add(
                LangDoctor(
                  lang: AppUtils.language,
                ),
              );

              selectedDegree = degreeList[0];
              selectedHomeVisit = homeVisitList[0];
              // government && city
              var governorates = snapshot.data.data.country.governorates;
              governorates.forEach((element) {
                governoratesList.add(element.name);
              });

              selectedGovernorate = governoratesList[0];

              var government = governorates
                  .firstWhere((element) => element.name == selectedGovernorate);
              government.cities.forEach((element) {
                cityList.add(element.name);
              });

              selectedCity = cityList[0];

              var currentGovernorate = governorates.firstWhere(
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

              // speciality
              var specialities = snapshot.data.data.specialty;
              specialities.forEach((element) {
                specialityList.add(element.name);
              });

              selectedSpeciality = specialityList[0];

              DoctorRegisterationPage.doctorRequest.city = num.parse(selectedCityId);
              DoctorRegisterationPage.doctorRequest.governorate = num.parse(selectedGovernorateId);

              gotData = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      getImage();
                    },
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: imageFile == null
                          ? AssetImage('assets/images/avatar.png')
                          : FileImage(imageFile),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    getImage();
                  },
                  child: Text(
                    imageErrorMsg ??
                        AppLocalization.of(context).translate('upload_photo'),
                    style: TextStyle(
                      color: imageErrorMsg == null ? mainColor : Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(28),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      title:
                          AppLocalization.of(context).translate('first_name'),
                      controller: firstNameController,
                      errorMessage: firstNameErrorMsg,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.firstName = input;
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTextFormField(
                      title: AppLocalization.of(context).translate('last_name'),
                      errorMessage: lastNameErrorMsg,
                      controller: lastNameController,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.lastName = input;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('personal_phone'),
                keyboardType: TextInputType.phone,
                errorMessage: phoneErrorMsg,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.phone = input;
                },
                controller: phoneController,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              Text(
                AppLocalization.of(context).translate('select_specialization'),
                style: TextStyle(color: Colors.grey),
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
                    value: selectedSpeciality,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: specialityList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (result) {
                      selectedSpeciality = result;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Text(
                AppLocalization.of(context).translate('select_degree'),
                style: TextStyle(color: Colors.grey),
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
                    value: degreeList == null ? null : selectedDegree,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: degreeList == null ? [] : degreeList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (result) {
                      selectedDegree = result;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Text(
                AppLocalization.of(context).translate('home_visit'),
                style: TextStyle(color: Colors.grey),
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
                    value: selectedHomeVisit,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: homeVisitList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (result) {
                      selectedHomeVisit = result;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('commercial_name'),
                controller: commercialNameController,
                errorMessage: commerciaNameErrorMsg,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.commercialName = input;
                },
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                controller: descriptionController,
                errorMessage: descriptionErrorMsg,
                maxLines: 5,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.description = input;
                },
              ),
              MyTextFormField(
                title: 'Short Description',
                controller: shortDescriptionController,
                maxLines: 3,
                errorMessage: shortDescriptionErrorMsg,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.shortDescription =
                      input;
                },
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                controller: emailController,
                errorMessage: emailErrorMsg,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.email = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('website'),
                controller: websiteController,
                errorMessage: websiteErrorMsg,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.website = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
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
                      var currentGovernorate =
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();

                      cityList.clear();
                      currentGovernorate.cities.forEach((element) {
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
                      var currentGovernorate =
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
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
                              if(index == 0) return;
                              List<LangDoctor> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DoctorPersonalLangPage(
                                    commercialName: langs[index].commercial_name,
                                    shortDescription: langs[index].short_description,
                                    lang: langs[index].lang,
                                    description: langs[index].description,
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
                    onTap: () async {
                      List<LangDoctor> addedLangs =
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorPersonalLangPage(),
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
                AppLocalization.of(context).translate('next'),
                btnColor: mainColor,
                onTap: () async {
                  await validateAndContinue(snapshot);
                  setState(() {});
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
            ],
          );
        }
      },
    );
  }

  void getImage() async {
    List<Asset> selectedImage = await AppUtils.getImage(1);
    if (selectedImage != null) {
      // file path
      var path = await FlutterAbsolutePath.getAbsolutePath(
        selectedImage[0].identifier,
      );

      imageFile = File(path);
      DoctorRegisterationPage.doctorRequest.image = imageFile;
      setState(() {});
    }
  }

  String getHomeVisitId() {
    if (selectedHomeVisit == homeVisitList[0]) {
      return '1';
    } else {
      return '0';
    }
  }

  String getDegreeId() {
    if (selectedDegree == degreeList[0]) {
      return 'specialist';
    } else if (selectedDegree == degreeList[1]) {
      return 'consultant';
    } else if (selectedDegree == degreeList[2]) {
      return 'lecturer';
    } else if (selectedDegree == degreeList[3]) {
      return 'associate_professor';
    } else if (selectedDegree == degreeList[4]) {
      return 'professor';
    }
  }

  String getSpecialityId(AsyncSnapshot<DoctorDetailsCreateResponse> snapshot) {
    var specialityList = snapshot.data.data.specialty;
    String id;
    specialityList.forEach((element) {
      if (selectedSpeciality == element.name) {
        id = element.id.toString();
      }
    });

    return id;
  }


  Future<void> validateAndContinue(snapshot) {
    AppUtils.hideKeyboard(context);

    // image
    if (imageFile == null) {
      imageErrorMsg = translate(context, 'required');
    } else {
      imageErrorMsg = null;
    }

    // first name
    if (firstNameController.text.isEmpty) {
      firstNameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (firstNameController.text.length < 2) {
      firstNameErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      firstNameErrorMsg = null;
    }

    // last name
    if (lastNameController.text.isEmpty) {
      lastNameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (lastNameController.text.length < 2) {
      lastNameErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      lastNameErrorMsg = null;
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

    // description
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      descriptionErrorMsg = null;
    }

    // short description
    if (shortDescriptionController.text.isEmpty) {
      shortDescriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      shortDescriptionErrorMsg = null;
    }

    if (DoctorRegisterationPage.doctorRequest.email != null && DoctorRegisterationPage.doctorRequest.email != '') {
      if (!PatternUtils.emailIsValid(email: DoctorRegisterationPage.doctorRequest.email)) {
        emailErrorMsg = translate(context, 'enter_valid_email');
      } else {
        emailErrorMsg = null;
      }
    }

    if (DoctorRegisterationPage.doctorRequest.website != '' && DoctorRegisterationPage.doctorRequest.website != null) {
      if (!PatternUtils.urlIsValid(url: DoctorRegisterationPage.doctorRequest.website)) {
        websiteErrorMsg = translate(context, 'enter_valid_url');
      } else {
        websiteErrorMsg = null;
      }
    }

    if (firstNameErrorMsg == null &&
        lastNameErrorMsg == null &&
        phoneErrorMsg == null &&
        descriptionErrorMsg == null &&
        shortDescriptionErrorMsg == null &&
        imageErrorMsg == null &&
        emailErrorMsg == null &&
        websiteErrorMsg == null) {

      DoctorRegisterationPage.doctorRequest.city = num.parse(selectedCityId);
      DoctorRegisterationPage.doctorRequest.governorate = num.parse(selectedGovernorateId);
      DoctorRegisterationPage.doctorRequest.degree = getDegreeId();
      DoctorRegisterationPage.doctorRequest.homeVisit = num.parse(getHomeVisitId());
      DoctorRegisterationPage.doctorRequest.categoryId = num.parse(getSpecialityId(snapshot));

      DoctorRegisterationPageState.currentIndicatorNumber = (2);
      setState(() {});
    }
  }
}
