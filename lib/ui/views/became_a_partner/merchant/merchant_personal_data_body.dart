import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/MerchantFormRequest.dart';
import 'package:phinex/Bles/Model/responses/store/StoreCreateDetailsResponse.dart';
import 'package:phinex/Bles/bloc/store/StoreBloc.dart';
import 'package:phinex/providers/merchant_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_merchant_lang_page.dart';
import 'merchant_regiteration_page.dart';

class MerchantPersonalDataBody extends StatefulWidget {
  @override
  _MerchantPersonalDataBodyState createState() =>
      _MerchantPersonalDataBodyState();
}

class _MerchantPersonalDataBodyState extends State<MerchantPersonalDataBody> {
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
  TextEditingController contactNumberController = TextEditingController();

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String profileImageResult = '';
  String selectedCategory = '';

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> categoriesList = [];

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
  String logoImageErrorMsg;
  String openAtErrorMsg;
  String closeAtErrorMsg;

  List<LangMerchant> langs = [];

  File logoImage;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StoreCreateDetailsResponse>(
      stream: storeBloc.storeCreateDetails.stream,
      builder: (context, snapshot) {
        if (storeBloc.loading.value) {
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

              MerchantRegisterationPage.merchantRequest = MerchantFormRequest();
              MerchantRegisterationPage.merchantRequest.deliveryStatus = 'none';
              MerchantRegisterationPage.merchantRequest.addressLongitude = double.parse(LONGITUDE);
              MerchantRegisterationPage.merchantRequest.addressLatitude = double.parse(LATITUDE);

              MerchantRegisterationPage.merchantRequest.city = num.parse(selectedCityId);
              MerchantRegisterationPage.merchantRequest.governorate = num.parse(selectedGovernorateId);

              // categories
              snapshot.data.data.categories.forEach((element) {
                categoriesList.add(element.name);
              });

              selectedCategory = categoriesList[0];

              snapshot.data.data.categories.forEach((element) {
                if (selectedCategory == element.name) {
                  MerchantRegisterationPage.merchantRequest.categoryId = element.id;
                }
              });

              langs.add(
                LangMerchant(
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
                        MerchantRegisterationPage.merchantRequest.firstName =
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
                        MerchantRegisterationPage.merchantRequest.lastName =
                            input;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('phone'),
                keyboardType: TextInputType.phone,
                errorMessage: phoneErrorMsg,
                onChanged: (String input) {
                  MerchantRegisterationPage.merchantRequest.phone = input;
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
                height: ScreenUtil().setHeight(12),
              ),
              MyUploadImageButton(
                title: translate(context, 'cover_image'),
                result: profileImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    logoImage = File(path);
                    MerchantRegisterationPage.merchantRequest.coverImage =
                        logoImage;

                    String name = basename(path);
                    profileImageResult = name;
                    setState(() {});
                  }
                },
              ),
              Text(
                logoImageErrorMsg ?? '',
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
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
                height: ScreenUtil().setHeight(12),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                errorMessage: emailErrorMsg,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onChanged: (String input) {
                  MerchantRegisterationPage.merchantRequest.email = input;
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
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();
                      MerchantRegisterationPage.merchantRequest.governorate =
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
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      MerchantRegisterationPage.merchantRequest.city =
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
                  MerchantRegisterationPage.merchantRequest.address = input;
                },
                controller: addressController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Text(
                translate(context, 'select_category'),
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
                    items: categoriesList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedCategory = newValue;
                      snapshot.data.data.categories.forEach((element) {
                        if (selectedCategory == element.name) {
                          MerchantRegisterationPage.merchantRequest.categoryId =
                              element.id;
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
                height: ScreenUtil().setHeight(15),
              ),
              MyTextFormField(
                title: translate(context, 'hotline'),
                keyboardType: TextInputType.number,
                errorMessage: hotlineErrorMsg,
                onChanged: (String input) {
                  MerchantRegisterationPage.merchantRequest.hotline =
                      num.parse(input);
                },
                controller: hotlineController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              MyTextFormField(
                title: translate(context, 'contact_number'),
                keyboardType: TextInputType.number,
                errorMessage: contactNumberErrorMsg,
                onChanged: (String input) {
                  MerchantRegisterationPage.merchantRequest.contactNumber =
                      num.parse(input);
                },
                controller: contactNumberController,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTimePicker(
                          title:
                              AppLocalization.of(context).translate('open_in'),
                          onTimeSelected: (String time, TimeOfDay timeOfDay) {
                            MerchantRegisterationPage
                                    .merchantRequest.openFromTime =
                                '${timeOfDay.hour}:${timeOfDay.minute}:00';
                          },
                        ),
                        Text(
                          openAtErrorMsg ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTimePicker(
                          title:
                              AppLocalization.of(context).translate('close_in'),
                          onTimeSelected: (String time, TimeOfDay timeOfDay) {
                            MerchantRegisterationPage
                                    .merchantRequest.openToTime =
                                '${timeOfDay.hour}:${timeOfDay.minute}:00';
                          },
                        ),
                        Text(
                          closeAtErrorMsg ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
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
                              List<LangMerchant> addedLangs =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddMerchantLangPage(
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
                    onTap: langs.length >= 2 ? null : () async {
                      List<LangMerchant> addedLangs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMerchantLangPage(),
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
                  validateAndContinue(context);
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
          MerchantRegisterationPage.merchantRequest.image = imageFile;
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void validateAndContinue(BuildContext context) {
    // image
    if (imageFile == null) {
      imageErrorMsg = translate(context, 'required');
    } else {
      imageErrorMsg = null;
    }

    if (logoImage == null) {
      logoImageErrorMsg = translate(context, 'required');
    } else {
      logoImageErrorMsg = null;
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

    // contact number
    if (contactNumberController.text.isEmpty) {
      contactNumberErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      contactNumberErrorMsg = null;
    }

    if (emailController.text.isEmpty) {
      emailErrorMsg = translate(context, 'required');
    } else {
        if (!PatternUtils.emailIsValid(email: emailController.text)) {
          emailErrorMsg = translate(context, 'enter_valid_email');
      } else {
          emailErrorMsg = null;
        }
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

    if (MerchantRegisterationPage.merchantRequest.openFromTime == null) {
      openAtErrorMsg = translate(context, 'enter_time_of_opining');
    } else {
      openAtErrorMsg = null;
    }

    if (MerchantRegisterationPage.merchantRequest.openToTime == null) {
      closeAtErrorMsg = translate(context, 'enter_time_of_closing');
    } else {
      closeAtErrorMsg = null;
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
        contactNumberErrorMsg == null &&
        logoImageErrorMsg == null &&
        closeAtErrorMsg == null &&
        openAtErrorMsg == null) {

      langs[0].commercialName = commercialNameController.text;
      langs[0].description = descriptionController.text;

      MerchantRegisterationPage.merchantRequest.city = num.parse(selectedCityId);
      MerchantRegisterationPage.merchantRequest.governorate = num.parse(selectedGovernorateId);
      MerchantRegisterationPage.merchantRequest.langs = langs;

      merchantProvider.setCurrentIndicatorNumber(2);
    }
  }
}
