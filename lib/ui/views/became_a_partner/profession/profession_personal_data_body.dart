import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/ProffessionsFormRequest.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionCreateDetailsResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/providers/profession_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_profession_lang_page.dart';
import 'profession_registeration_page.dart';

class ProfessionPersonalDataBody extends StatefulWidget {
  @override
  _ProfessionPersonalDataBodyState createState() => _ProfessionPersonalDataBodyState();
}

class _ProfessionPersonalDataBodyState extends State<ProfessionPersonalDataBody> {
  File imageFile;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String selectedSpecialty = '';

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> categoryList = [];

  bool gotData = false;

  String imageErrorMsg;
  String emailErrorMsg;
  String websiteErrorMsg;
  String firstNameErrorMsg;
  String lastNameErrorMsg;
  String addressErrorMsg;
  String phoneErrorMsg;
  String titlErrorMsg;
  String descriptionErrorMsg;
  String shortDescriptionErrorMsg;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfessionCreateDetailsResponse>(
      stream: professionsBloc.professionCreateDetails.stream,
      builder: (context, snapshot) {
        if (professionsBloc.loading.value) {
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
              snapshot.data.data.country.governorates.forEach((element) {
                governoratesList.add(element.name);
              });

              selectedGovernorate = governoratesList[0];

              var government = snapshot.data.data.country.governorates
                  .firstWhere((element) => element.name == selectedGovernorate);
              government.cities.forEach((element) {
                cityList.add(element.name);
              });

              selectedCity = cityList[0];

              var currentGovernorate =
                  snapshot.data.data.country.governorates.firstWhere(
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

              snapshot.data.data.categories.forEach((element) {
                categoryList.add(element.name);
              });

              selectedSpecialty = categoryList[0];

              snapshot.data.data.categories.forEach((element) {
                if (selectedSpecialty == element.name) {
                  ProfessionRegisterationPage.professionRequest.categoryId =
                      element.id;
                }
              });

              ProfessionRegisterationPage.professionRequest.langs = [];
              ProfessionRegisterationPage.professionRequest.langs.add(LangProffessionBean(
                lang: AppUtils.language,
              ));

              ProfessionRegisterationPage.professionRequest.city =
                  num.parse(selectedCityId);

              ProfessionRegisterationPage.professionRequest.governorate =
                  num.parse(selectedGovernorateId);

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
                        ProfessionRegisterationPage
                            .professionRequest.firstName = input;
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
                        ProfessionRegisterationPage.professionRequest.lastName =
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
                  ProfessionRegisterationPage.professionRequest.phone = input;
                },
                controller: phoneController,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(8),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('commercial_name'),
                errorMessage: titlErrorMsg,
                controller: titleController,
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.langs[0].commercial_name =
                      input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(12),
              ),
              MyTextFormField(
                title: translate(context, 'description'),
                errorMessage: descriptionErrorMsg,
                maxLines: 5,
                controller: descriptionController,
                onChanged: (String input) {
                  ProfessionRegisterationPage
                      .professionRequest.langs[0].description = input;
                },
              ),
              MyTextFormField(
                title: translate(context, 'short_description'),
                errorMessage: shortDescriptionErrorMsg,
                controller: shortDescriptionController,
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.langs[0].short_description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(12),
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
                      ProfessionRegisterationPage.professionRequest
                          .governorate = int.parse(selectedGovernorateId);

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
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      ProfessionRegisterationPage.professionRequest.city =
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
              MyTextFormField(
                title: AppLocalization.of(context).translate('address'),
                errorMessage: addressErrorMsg,
                controller: addressController,
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.langs[0].commercial_name =
                      input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(12),
              ),
              Text(
                translate(context, 'select_working_type'),
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
                    value: selectedSpecialty,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: categoryList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedSpecialty = newValue;

                      snapshot.data.data.categories.forEach((element) {
                        if (selectedSpecialty == element.name) {
                          ProfessionRegisterationPage
                              .professionRequest.categoryId = element.id;
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
                              List<LangProffessionBean> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddProfessionLangPage(
                                    title: ProfessionRegisterationPage.professionRequest.langs[index].commercial_name,
                                    address: ProfessionRegisterationPage.professionRequest.langs[index].short_description,
                                    lang: ProfessionRegisterationPage.professionRequest.langs[index].lang,
                                    description: ProfessionRegisterationPage.professionRequest.langs[index].description,
                                  ),
                                ),
                              );
                              if (addedLangs != null && addedLangs.isNotEmpty) {
                                ProfessionRegisterationPage.professionRequest.langs.addAll(addedLangs);
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
                                  ProfessionRegisterationPage.professionRequest.langs[index].lang,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: ProfessionRegisterationPage.professionRequest.langs.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: ProfessionRegisterationPage.professionRequest.langs.length >= 2 ? null : () async {
                      List<LangProffessionBean> addedLangs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddProfessionLangPage(),
                        ),
                      );
                      if (addedLangs != null && addedLangs.isNotEmpty) {
                        ProfessionRegisterationPage.professionRequest.langs.addAll(addedLangs);
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
          ProfessionRegisterationPage.professionRequest.image = imageFile;
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

    // address
    if (addressController.text.isEmpty) {
      addressErrorMsg = AppLocalization.of(context).translate("required");
    } else if (addressController.text.length < 2) {
      addressErrorMsg = AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      addressErrorMsg = null;
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

    // title
    if (titleController.text.isEmpty) {
      titlErrorMsg =
          AppLocalization.of(context).translate("required");
    } else {
      titlErrorMsg = null;
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

    setState(() {});

    if (firstNameErrorMsg == null &&
        lastNameErrorMsg == null &&
        phoneErrorMsg == null &&
        imageErrorMsg == null &&
        titlErrorMsg == null &&
        descriptionErrorMsg == null && shortDescriptionErrorMsg == null) {

      ProfessionRegisterationPage.professionRequest.city = num.parse(selectedCityId);
      ProfessionRegisterationPage.professionRequest.governorate = num.parse(selectedGovernorateId);

      professionProvider.setCurrentIndicatorNumber(2);
    }
  }
}
