import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/RealStateFormRequest.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/real_estate_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_real_state_lang_page.dart';
import 'real_state_registeration_page.dart';

class RealStatePersonalDataBody extends StatefulWidget {
  @override
  _RealStatePersonalDataBodyState createState() =>
      _RealStatePersonalDataBodyState();
}

class _RealStatePersonalDataBodyState extends State<RealStatePersonalDataBody> {
  File imageFile;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController hotlineController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<LangRealState> langs = [];

  bool gotData = false;

  String imageErrorMsg;
  String firstNameErrorMsg;
  String lastNameErrorMsg;
  String addressErrorMsg;
  String phoneErrorMsg;
  String commercialNameErrorMsg;
  String descriptionErrorMsg;
  String emailErrorMsg;
  String websiteErrorMsg;
  String hotlineErrorMsg;
  String contactNumberErrorMsg;
  String contactPersonErrorMsg;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GeneralModelGovResponse>(
      stream: generalBloc.generalGovModel.stream,
      builder: (context, snapshot) {
        if (generalBloc.loading.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Loader(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
            ],
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            if (!gotData) {
              snapshot.data.data.governorates.forEach((element) {
                governoratesList.add(element.name);
              });

              selectedGovernorate = governoratesList[0];

              var government = snapshot.data.data.governorates
                  .firstWhere((element) => element.name == selectedGovernorate);
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

              RealStateRegiserationPage.realStateRequest.city =
                  num.parse(selectedCityId);
              RealStateRegiserationPage.realStateRequest.governorate =
                  num.parse(selectedGovernorateId);

              langs.add(
                LangRealState(
                  lang: AppUtils.language,
                ),
              );

              gotData = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
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
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
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
                        RealStateRegiserationPage.realStateRequest.firstName =
                            input;
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
                        RealStateRegiserationPage.realStateRequest.lastName =
                            input;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('phone'),
                keyboardType: TextInputType.phone,
                errorMessage: phoneErrorMsg,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.phone = input;
                },
                controller: phoneController,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(8),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('commercial_name'),
                errorMessage: commercialNameErrorMsg,
                controller: commercialNameController,
                onChanged: (String input) {
                  langs[0].commercialName = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                errorMessage: descriptionErrorMsg,
                maxLines: 5,
                controller: descriptionController,
                onChanged: (String input) {
                  langs[0].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                errorMessage: emailErrorMsg,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.email = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
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
                          snapshot.data.data.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();
                      RealStateRegiserationPage.realStateRequest.governorate =
                          int.parse(selectedGovernorateId);

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
              SizedBox(
                height: 8,
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
                          snapshot.data.data.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      RealStateRegiserationPage.realStateRequest.city =
                          int.parse(selectedCityId);

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
                height: 8,
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('address'),
                errorMessage: addressErrorMsg,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.address = input;
                },
                controller: addressController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              MyTextFormField(
                title: translate(context, 'hotline'),
                keyboardType: TextInputType.number,
                errorMessage: hotlineErrorMsg,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.hotline =
                      num.parse(input);
                },
                controller: hotlineController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              MyTextFormField(
                title: translate(context, 'contact_person'),
                keyboardType: TextInputType.number,
                errorMessage: contactPersonErrorMsg,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.contactPerson =
                      num.parse(input);
                },
                controller: contactPersonController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              MyTextFormField(
                title: translate(context, 'contact_number'),
                keyboardType: TextInputType.number,
                errorMessage: contactNumberErrorMsg,
                onChanged: (String input) {
                  RealStateRegiserationPage.realStateRequest.contactNumber =
                      num.parse(input);
                },
                controller: contactNumberController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
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
                              List<LangRealState> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddRealStateLangPage(
                                    commercialName: langs[index].commercialName,
                                    lang: langs[index].lang,
                                    description: langs[index].description,
                                  ),
                                ),
                              );
                              if (addedLangs != null && addedLangs.isNotEmpty) {
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
                                borderRadius: BorderRadius.circular(20),
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
                    onTap: langs.length >= 2 ? null :  () async {
                      List<LangRealState> addedLangs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddRealStateLangPage(),
                        ),
                      );
                      if (addedLangs != null && addedLangs.isNotEmpty) {
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
                translate(context, 'next'),
                onTap: () {
                  validateAndContinue();
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
            ],
          );
        }
      },
    );
  }

  void getImage() async {
    bool permissionIsGranted = await AppUtils.askPhotosPermission();
    if (permissionIsGranted) {
      try {
        var selectedImage = await MultiImagePicker.pickImages(
          maxImages: 1,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: APP_NAME),
          materialOptions: MaterialOptions(
            actionBarColor: "#ff16135A",
            actionBarTitle: APP_NAME,
            allViewTitle: "All Photos",
            useDetailsView: false,
            autoCloseOnSelectionLimit: false,
            startInAllView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );

        if (selectedImage != null) {
          // print file path
          var path = await FlutterAbsolutePath.getAbsolutePath(
            selectedImage[0].identifier,
          );

          imageFile = File(path);
          RealStateRegiserationPage.realStateRequest.image = imageFile;
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void validateAndContinue() {
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

    // address
    if (addressController.text.isEmpty) {
      addressErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      addressErrorMsg = null;
    }

    // commercial name
    if (commercialNameController.text.isEmpty) {
      commercialNameErrorMsg =
          AppLocalization.of(context).translate("required");
    } else {
      commercialNameErrorMsg = null;
    }

    // description
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      descriptionErrorMsg = null;
    }

    // hotline
    if (hotlineController.text.isEmpty) {
      hotlineErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      hotlineErrorMsg = null;
    }

    // contact person
    if (contactPersonController.text.isEmpty) {
      contactPersonErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      contactPersonErrorMsg = null;
    }

    // contact number
    if (contactNumberController.text.isEmpty) {
      contactNumberErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      contactNumberErrorMsg = null;
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

    if (websiteController.text.isNotEmpty) {
      if (!PatternUtils.urlIsValid(url: websiteController.text)) {
        websiteErrorMsg = translate(context, 'enter_valid_url');
      } else {
        websiteErrorMsg = null;
      }
    } else {
      websiteErrorMsg = null;
    }

    setState(() {});

    if (firstNameErrorMsg == null &&
        lastNameErrorMsg == null &&
        phoneErrorMsg == null &&
        addressErrorMsg == null &&
        imageErrorMsg == null &&
        commercialNameErrorMsg == null &&
        descriptionErrorMsg == null &&
        emailErrorMsg == null &&
        websiteErrorMsg == null &&
        hotlineErrorMsg == null &&
        contactPersonErrorMsg == null &&
        contactNumberErrorMsg == null) {

      RealStateRegiserationPage.realStateRequest.city = num.parse(selectedCityId);
      RealStateRegiserationPage.realStateRequest.governorate = num.parse(selectedGovernorateId);
      RealStateRegiserationPage.realStateRequest.langs = langs;

      realEstateProvider.setCurrentIndicatorNumber(2);
    }
  }
}
