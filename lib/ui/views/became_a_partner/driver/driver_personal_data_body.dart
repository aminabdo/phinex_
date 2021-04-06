import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'driver_registeration_page.dart';

class DriverPersonalDataBody extends StatefulWidget {
  @override
  _DriverPersonalDataBodyState createState() => _DriverPersonalDataBodyState();
}

class _DriverPersonalDataBodyState extends State<DriverPersonalDataBody> {
  File imageFile;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  List<String> governoratesList = [];
  List<String> cityList = [];

  bool gotData = false;

  String imageErrorMsg;
  String firstNameErrorMsg;
  String lastNameErrorMsg;
  String phoneErrorMsg;

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

              DriverRegisterationPage.driverRequest.city =
                  num.parse(selectedCityId);
              DriverRegisterationPage.driverRequest.governorate =
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
                        DriverRegisterationPage.driverRequest.firstName = input;
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
                        DriverRegisterationPage.driverRequest.lastName = input;
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
                  DriverRegisterationPage.driverRequest.phone = input;
                },
                controller: phoneController,
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
                          snapshot.data.data.governorates.firstWhere(
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
                height: ScreenUtil().setWidth(12),
              ),
              myButton(
                AppLocalization.of(context).translate('next'),
                btnColor: mainColor,
                onTap: () {
                  checkValuesAndContinue();
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
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
          DriverRegisterationPage.driverRequest.image = imageFile;
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void checkValuesAndContinue() {
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
    } else if (phoneController.text.length < 9) {
      phoneErrorMsg =
          AppLocalization.of(context).translate("mobile_length_not_valid");
    } else {
      phoneErrorMsg = null;
    }

    if (firstNameErrorMsg == null &&
        lastNameErrorMsg == null &&
        phoneErrorMsg == null &&
        imageErrorMsg == null) {

      DriverRegisterationPage.driverRequest.city = num.parse(selectedCityId);
      DriverRegisterationPage.driverRequest.governorate = num.parse(selectedGovernorateId);

      driverProvider.setCurrentIndicatorNumber(2);
    }
  }
}
