import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/CarRentalFormRequest.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/car_rental/CarRentalBloc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/widgets/done_dialog.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_car_rental_lang_page.dart';

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String selectedCarModel = '';
  String selectedRentalPeriod = '';
  String selectedBodyType = '';
  String selectedTransmission = '';
  String selectedManufactureYear = '';
  String selectedGovernorate = '';
  String selectedCity = '';
  String phoneErrorMsg = '';

  String selectedCarModelErrorMsg = '';
  String businessActivityErrorMsg = '';
  String selectedRentalPeriodErrorMsg = '';
  String selectedBodyTypeErrorMsg = '';
  String selectedTransmissionErrorMsg = '';
  String selectedManufactureYearErrorMsg = '';
  String colorErrorMsg = '';
  String priceErrorMsg = '';
  String coverErrorMsg = '';
  String photosErrorMsg = '';
  String titleErrorMsg = '';

  String companyLogoResult = '';
  String photosResult = '';
  String selectedGovernorateId;
  String selectedCityId;
  String modelId;

  TextEditingController businessActivityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool hasDriver = false;
  bool doneStatus = true;
  bool isLoading = false;
  bool gotModels = false;

  List<File> photos = [];
  List<LangCarRentalBean> langs = [];

  File coverImage;

  List<String> rentalPeriods;
  List<String> bodyTypeList = [
    'Sedan',
    'SUV',
    'hatchback',
    'truck',
    'van',
    'motocycle'
  ];

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  List<String> transmissionList;
  List<String> manufactureYearList = [];
  List<String> modelsList = [];
  List<String> governoratesList = [];
  List<String> cityList = [];

  @override
  void initState() {
    super.initState();

    for (int i = DateTime.now().year; i >= DateTime.now().year - 100; i--) {
      manufactureYearList.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    rentalPeriods = [
      translate(context, 'hour'),
      translate(context, 'day'),
      translate(context, 'week'),
      translate(context, 'month'),
      translate(context, 'year'),
    ];

    transmissionList = [
      translate(context, 'manual'),
      translate(context, 'automatic'),
    ];

    if (doneStatus) {
      doneStatus = false;
      selectedManufactureYear = manufactureYearList[0];
      selectedRentalPeriod = rentalPeriods[0];
      selectedBodyType = bodyTypeList[0];
      selectedTransmission = transmissionList[0];
    }

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'add_car'),
        context,
      ),
      body: StreamBuilder<GeneralModelGovResponse>(
        stream: generalBloc.generalGovModel.stream,
        builder: (context, snapshot) {
          if (generalBloc.loading.value) {
            return Loader();
          } else {
            if (snapshot.hasData && snapshot.data != null) {

              if (!gotModels) {
                snapshot.data.data.governorates.forEach((element) {
                  governoratesList.add(element.name);
                });

                selectedGovernorate = governoratesList[0];

                var government = snapshot.data.data.governorates.firstWhere(
                    (element) => element.name == selectedGovernorate);
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

                generalBloc.models.value.forEach((element) {
                  modelsList.add(element.modelName);
                });

                selectedCarModel = modelsList.isNotEmpty ? modelsList[0] : '';

                generalBloc.models.value.forEach((element) {
                  if (selectedCarModel == element.modelName) {
                    modelId = element.id.toString();
                  }
                });

                langs.add(
                  LangCarRentalBean(
                    lang: AppUtils.language,
                  ),
                );

                gotModels = true;
              }
            }
            return LoadingOverlay(
              isLoading: isLoading,
              opacity: .5,
              progressIndicator: Loader(),
              color: Colors.white,
              child: Padding(
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
                        translate(context, 'car_mode'),
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
                            value: selectedCarModel,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: modelsList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedCarModel = newValue;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedCarModelErrorMsg ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      Text(
                        translate(context, 'rental_period'),
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
                            value: selectedRentalPeriod,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: rentalPeriods.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedRentalPeriod = newValue;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedRentalPeriodErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        translate(context, 'body_type'),
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
                            value: selectedBodyType,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: bodyTypeList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedBodyType = newValue;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedBodyTypeErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        translate(context, 'transmission'),
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
                            value: selectedTransmission,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: transmissionList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedTransmission = newValue;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedTransmissionErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      MyTextFormField(
                        title: translate(context, 'title'),
                        errorMessage: titleErrorMsg,
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            titleErrorMsg = AppLocalization.of(context).translate("required");
                          } else {
                            titleErrorMsg = null;
                          }
                          setState(() {});
                        },
                      ),
                      MyTextFormField(
                        title: translate(context, 'color'),
                        errorMessage: colorErrorMsg,
                        controller: colorController,
                        keyboardType: TextInputType.text,
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            colorErrorMsg = AppLocalization.of(context)
                                .translate("required");
                          } else {
                            colorErrorMsg = null;
                          }
                          setState(() {});
                        },
                      ),
                      MyTextFormField(
                        title: translate(context, 'price'),
                        errorMessage: priceErrorMsg,
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            priceErrorMsg = AppLocalization.of(context)
                                .translate("required");
                          } else {
                            priceErrorMsg = null;
                          }
                          setState(() {});
                        },
                      ),
                      MyTextFormField(
                        title: translate(context, 'phone'),
                        errorMessage: phoneErrorMsg,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            phoneErrorMsg = AppLocalization.of(context)
                                .translate("required");
                          } else {
                            phoneErrorMsg = null;
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Text(
                        translate(context, 'manufacture_year'),
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
                            value: selectedManufactureYear,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: manufactureYearList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedManufactureYear = newValue;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedManufactureYearErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      MyUploadImageButton(
                        title: translate(context, 'cover_image'),
                        result: companyLogoResult,
                        onTap: () async {
                          bool permissionIsGranted =
                              await AppUtils.askPhotosPermission();
                          if (permissionIsGranted) {
                            try {
                              var resultList =
                                  await MultiImagePicker.pickImages(
                                maxImages: 1,
                                cupertinoOptions:
                                    CupertinoOptions(takePhotoIcon: APP_NAME),
                                materialOptions: MaterialOptions(
                                  actionBarColor: "#ff16135A",
                                  actionBarTitle: APP_NAME,
                                  allViewTitle: "All Photos",
                                  useDetailsView: false,
                                  autoCloseOnSelectionLimit: true,
                                  startInAllView: false,
                                  selectCircleStrokeColor: "#000000",
                                ),
                              );

                              // print file path
                              var path =
                                  await FlutterAbsolutePath.getAbsolutePath(
                                resultList[0].identifier,
                              );

                              coverImage = File(path);

                              // print file name
                              String name = basename(path);
                              companyLogoResult = name;
                              setState(() {});
                            } on Exception catch (e) {
                              print(e.toString());
                            }
                          } else {
                            AppUtils.showToast(msg: 'Accept Permission first');
                          }
                        },
                      ),
                      Text(
                        coverErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      MyUploadImageButton(
                        title: translate(context, 'photos'),
                        result: photosResult,
                        onTap: () async {
                          bool permissionIsGranted =
                              await AppUtils.askPhotosPermission();
                          if (permissionIsGranted) {
                            try {
                              var resultList =
                                  await MultiImagePicker.pickImages(
                                maxImages: 10,
                                cupertinoOptions:
                                    CupertinoOptions(takePhotoIcon: APP_NAME),
                                materialOptions: MaterialOptions(
                                  actionBarColor: "#ff16135A",
                                  actionBarTitle: APP_NAME,
                                  allViewTitle: "All Photos",
                                  useDetailsView: false,
                                  autoCloseOnSelectionLimit: true,
                                  startInAllView: false,
                                  selectCircleStrokeColor: "#000000",
                                ),
                              );

                              photos.clear();

                              for (int i = 0; i < resultList.length; i++) {
                                photos.add(
                                  File(
                                    await FlutterAbsolutePath.getAbsolutePath(
                                      resultList[i].identifier,
                                    ),
                                  ),
                                );
                              }
                              photosResult =
                                  '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                              setState(() {});
                            } on Exception catch (e) {
                              print(e.toString());
                            }
                          } else {
                            AppUtils.showToast(
                              msg: 'Accept Permission first',
                            );
                          }
                        },
                      ),
                      Text(
                        photosErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      photos.isEmpty
                          ? SizedBox.shrink()
                          : Container(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(90),
                              margin: EdgeInsets.only(
                                left: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? 8
                                    : 0,
                                right: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? 0
                                    : 8,
                              ),
                              child: ListView.builder(
                                physics: bouncingScrollPhysics,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(100),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Image.file(
                                          photos[index],
                                          fit: BoxFit.fill,
                                        ),
                                        margin: EdgeInsets.only(right: 8),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: -8,
                                        child: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            photos.removeAt(index);
                                            if (photos.isEmpty) {
                                              photosResult = '';
                                            } else {
                                              photosResult =
                                                  '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                                            }

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: photos.length,
                              ),
                            ),
                      SizedBox(
                        height: ScreenUtil().setHeight(photos.isEmpty ? 5 : 15),
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
                                (element) =>
                                    element.name == selectedGovernorate,
                              );
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
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        selectedManufactureYearErrorMsg ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                      MyTextFormField(
                        title: translate(context, 'business_activity'),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        errorMessage: businessActivityErrorMsg,
                        controller: businessActivityController,
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(10),
                      ),
                      GestureDetector(
                        onTap: () {
                          hasDriver = !hasDriver;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: hasDriver,
                              onChanged: (bool val) {
                                hasDriver = val;
                                setState(() {});
                              },
                            ),
                            Text(
                              translate(context, 'has_driver'),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
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
                                      List<LangCarRentalBean> addedLangs =
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddCarRentalLangPage(
                                                title: langs[index].title,
                                                color: langs[index].color,
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
                            onTap: langs.length >= 2 ? null : () async {
                              List<LangCarRentalBean> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddCarRentalLangPage(),
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
                        translate(context, 'add_car'),
                        btnColor: mainColor,
                        onTap: () {
                          createNewCarRental(context, snapshot);
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void createNewCarRental(BuildContext context,
      AsyncSnapshot<GeneralModelGovResponse> snapshot) async {
    AppUtils.hideKeyboard(context);

    // cover image
    if (coverImage == null) {
      coverErrorMsg = translate(context, 'required');
    }

    // photos
    if (photos.isEmpty || photos.length == 0) {
      photosErrorMsg = translate(context, 'required');
    }

    // price
    if (priceController.text.isEmpty) {
      priceErrorMsg = AppLocalization.of(context).translate("required");
    } else if (num.tryParse(priceController.text) < 0) {
      priceErrorMsg = translate(context, 'invalid_price');
    } else {
      priceErrorMsg = null;
    }

    // title
    if (titleController.text.isEmpty) {
      titleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      titleErrorMsg = translate(context, 'invalid_length');
    } else {
      titleErrorMsg = null;
    }

    // color
    if (colorController.text.isEmpty) {
      colorErrorMsg = AppLocalization.of(context).translate("required");
    } else if (colorController.text.length < 0) {
      colorErrorMsg = translate(context, 'invalid_length');
    } else {
      colorErrorMsg = null;
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

    // Business Activity
    if (businessActivityController.text.isEmpty) {
      businessActivityErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (businessActivityController.text.length < 2) {
      businessActivityErrorMsg = translate(context, 'invalid_length');
    } else {
      businessActivityErrorMsg = null;
    }

    setState(() {});

    if (businessActivityErrorMsg == null &&
        priceErrorMsg == null &&
        coverImage != null &&
        colorErrorMsg == null &&
        photos.isNotEmpty) {

      generalBloc.models.value?.forEach((element) {
        if (selectedCarModel == element.modelName) {
          modelId = element.id.toString();
        }
      });

      generalBloc.governorates.value?.forEach((element) {
        if (selectedGovernorate == element.name) {
          selectedGovernorateId = element.id.toString();
        }
      });

      var currentGovernorate = snapshot.data.data.governorates.firstWhere(
        (element) => element.name == selectedGovernorate,
      );

      currentGovernorate.cities.forEach((element) {
        if (element.name == selectedCity) {
          selectedCityId = element.id.toString();
        }
      });

      langs[0].title = titleController.text;
      langs[0].color = colorController.text;
      langs[0].description = businessActivityController.text;

      var request = CarRentalFormRequest(
        gallery: photos,
        main_image: coverImage,
        phone: phoneController.text,
        governorate: selectedGovernorateId,
        city: selectedCityId,
        userId: AppUtils.userData?.id.toString(),
        transmission: selectedTransmission == transmissionList[0] ? 'manual' : 'automatic',
        manufacturerYear: selectedManufactureYear,
        bodyType: selectedBodyType,
        carModelId: modelId,
        hasDriver: hasDriver ? '1' : '0',
        rentalPeriod: rentalPeroid(),
        rentalPricePerPeriod: priceController.text,
        country: await AppUtils.getCountryId().toString(),
        langs: langs,
      );

      print(request.toJson());

      isLoading = true;
      setState(() {});
      var response = await carRentalBloc.createCar(request);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isLoading = false;
        setState(() {});
        print(response.data.toString());
        carRentalBloc.create.onListen = null;
        await showDialog(
          context: context,
          builder: (_) => DoneDialogContent(
            msg: translate(context, 'car_added_successfully'),
          ),
        );
        Navigator.pop(context);
      } else {
        isLoading = false;
        setState(() {});
        print(response.toString());
        print('>>>>>>>>>>>>>');
        AppUtils.showToast(msg: response.data['message'][0].toString());
      }
    }
  }

  String rentalPeroid() {
    if(selectedRentalPeriod == rentalPeriods[0]) { // hour
      return 'hour';
    }
    if(selectedRentalPeriod == rentalPeriods[1]) { // day
      return 'day';
    }
    if(selectedRentalPeriod == rentalPeriods[2]) { // week
      return 'week';
    }
    if(selectedRentalPeriod == rentalPeriods[3]) { // month
      return 'month';
    }
    if(selectedRentalPeriod == rentalPeriods[4]) { // year
      return 'year';
    }
  }
}
