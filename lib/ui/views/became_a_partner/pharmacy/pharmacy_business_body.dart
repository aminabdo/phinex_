import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/PharmaCistFormRequest.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/pharmacy_provider.dart';
import 'package:phinex/ui/views/became_a_partner/pharmacy/pharmacy_regiteration_page.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'add_pharmacy_lang_page.dart';

class PharmacyBussinesBody extends StatefulWidget {
  @override
  _PharmacyBussinesBodyState createState() => _PharmacyBussinesBodyState();
}

class _PharmacyBussinesBodyState extends State<PharmacyBussinesBody> {
  List<Widget> workshopsList = [];
  bool fillForm = false;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    if (!fillForm) {
      fillForm = true;
      PharmacyRegisterationPage.pharmacyRequest.pharmacies = [];
      PharmacyRegisterationPage.pharmacyRequest.pharmacies.add(PharmaciesBean());
      workshopsList.add(
        workshopForm(context, 0),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextFormField(
          title: AppLocalization.of(context).translate('commercial_name'),
          onChanged: (String input) {
            PharmacyRegisterationPage.pharmacyRequest.commercialName = input;
          },
        ),
        MyTextFormField(
          title: AppLocalization.of(context).translate('description'),
          maxLines: 5,
          onChanged: (String input) {
            PharmacyRegisterationPage.pharmacyRequest.description = input;
          },
        ),
        MyTextFormField(
          title: translate(context, 'short_description'),
          maxLines: 3,
          onChanged: (String input) {
            PharmacyRegisterationPage.pharmacyRequest.shortDescription = input;
          },
        ),
        ListView.separated(
          itemBuilder: (context, index) {
            return workshopsList[index];
          },
          itemCount: workshopsList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: ScreenUtil().setHeight(15),
            );
          },
        ),
        SizedBox(
          height: ScreenUtil().setWidth(20),
        ),
        FlatButton(
          onPressed: () {
            PharmacyRegisterationPage.pharmacyRequest.pharmacies.add(PharmaciesBean());
            workshopsList.add(
              workshopForm(context, workshopsList.length,
                  onDeleteBtnTapped: () {
                PharmacyRegisterationPage.pharmacyRequest.pharmacies.removeAt(workshopsList.length);
                workshopsList.removeAt(workshopsList.length - 1);

                setState(() {});
              }),
            );
            setState(() {});
          },
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: deepBlueColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                translate(context, 'add_another_pharmacy'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setWidth(15),
        ),
        myButton(
          AppLocalization.of(context).translate('next'),
          btnColor: mainColor,
          onTap: () {
            validateAndContineu(context);
          },
        ),
        SizedBox(
          height: ScreenUtil().setWidth(30),
        ),
      ],
    );
  }

  Widget workshopForm(BuildContext context, int index, {Function onDeleteBtnTapped}) {
    // We start with all days selected.
    final values = List.filled(7, false);

    List<LangPharmacist> langs = [];
    langs.add(
      LangPharmacist(
        lang: AppUtils.language,
      ),
    );

    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].langs = [];
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].langs = langs;

    List<String> deliveryStatusList = [
      translate(context, 'all_24_hours'),
      translate(context, 'as_open'),
      translate(context, 'none')
    ];
    List<String> homeVisitList = [
      translate(context, 'available'),
      translate(context, 'not_available')
    ];
    List<String> governoratesList = [];
    List<String> cityList = [];

    String selectedGovernorate = '';
    String selectedGovernorateId = '';
    String selectedCity = '';
    String selectedCityId = '';

    String selectedDeliveryStatus = deliveryStatusList[0];
    String selectedHomeVisit = homeVisitList[0];

    if (selectedDeliveryStatus == deliveryStatusList[0]) {
      PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].deliveryStatus = '24/7';
    } else if (selectedDeliveryStatus == deliveryStatusList[1]) {
      PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].deliveryStatus = 'as_open';
    } else {
      PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].deliveryStatus = 'none';
    }

    if (selectedHomeVisit == homeVisitList[0]) {
      PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].homeVisit = 1;
    } else {
      PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].homeVisit = 0;
    }

    String coverImageResult = '';
    String profileImageResult = '';
    String photosResult = '';
    List<File> photos = [];
    File coverImage;
    File logoImage;

    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].saturday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].sunday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].monday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].tuesday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].wednesday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].thursday = 0;
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].friday = 0;

    var _generalBloc = generalBloc.generalGovModel.value.data;

    generalBloc.generalGovModel.value.data.governorates.forEach((element) {
      governoratesList.add(element.name);
    });

    selectedGovernorate = governoratesList[0];

    var currentGovernment = _generalBloc.governorates
        .firstWhere((element) => element.name == selectedGovernorate);
    currentGovernment.cities.forEach((element) {
      cityList.add(element.name);
    });

    selectedCity = cityList[0];

    selectedGovernorateId = currentGovernment.id.toString();

    currentGovernment.cities.forEach(
      (element) {
        if (element.name == selectedCity) {
          selectedCityId = element.id.toString();
        }
      },
    );

    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].city = num.parse(selectedCityId);
    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].governorate = num.parse(selectedGovernorateId);

    return StatefulBuilder(
      builder: (context, setState) => Card(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              index != 0
                  ? Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: onDeleteBtnTapped,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Text(
                '${translate(context, 'pharmacy')} #${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: translate(context, 'title'),
                onChanged: (String input) {
                  PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].langs[index].title = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: translate(context, 'phone'),
                keyboardType: TextInputType.phone,
                onChanged: (String input) {
                  PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].phone = int.parse(input);
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                maxLines: 5,
                onChanged: (String input) {
                  PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].langs[index].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: translate(context, 'address'),
                onChanged: (String input) {
                  PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].langs[index].address = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                onChanged: (String input) {
                  PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].email = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('website'),
                onChanged: (String input) {
                  PharmacyRegisterationPage
                      .pharmacyRequest.pharmacies[index].website = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              Text(
                translate(context, 'delivery_status'),
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
                    value: selectedDeliveryStatus,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: deliveryStatusList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedDeliveryStatus = newValue;
                      if (selectedDeliveryStatus == deliveryStatusList[0]) {
                        PharmacyRegisterationPage.pharmacyRequest
                            .pharmacies[index].deliveryStatus = '24/7';
                      } else if (selectedDeliveryStatus ==
                          deliveryStatusList[1]) {
                        PharmacyRegisterationPage.pharmacyRequest
                            .pharmacies[index].deliveryStatus = 'as_open';
                      } else {
                        PharmacyRegisterationPage.pharmacyRequest
                            .pharmacies[index].deliveryStatus = 'none';
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Text(
                translate(context, 'home_visit'),
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
                    onChanged: (newValue) {
                      selectedHomeVisit = newValue;
                      if (selectedHomeVisit == homeVisitList[0]) {
                        PharmacyRegisterationPage
                            .pharmacyRequest.pharmacies[index].homeVisit = 1;
                      } else {
                        PharmacyRegisterationPage
                            .pharmacyRequest.pharmacies[index].homeVisit = 0;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              MyUploadImageButton(
                title: translate(context, 'cover_image'),
                result: coverImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    coverImage = File(path);
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index].coverImage = coverImage;

                    String name = basename(path);
                    coverImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: translate(context, 'logo_image'),
                result: profileImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    logoImage = File(path);
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .logoImage = logoImage;

                    String name = basename(path);
                    profileImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: translate(context, 'photos'),
                result: photosResult,
                onTap: () async {
                  List<Asset> resultList = await AppUtils.getImage(10);
                  if (resultList != null) {
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

                    PharmacyRegisterationPage
                        .pharmacyRequest.pharmacies[index].gallery = photos;
                    photosResult =
                        '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              photos.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(90),
                      margin: EdgeInsets.only(
                        left:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? 8
                                : 0,
                        right:
                            Localizations.localeOf(context).languageCode == 'en'
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
                                  borderRadius: BorderRadius.circular(5),
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
                height: ScreenUtil().setWidth(15),
              ),
              Text(
                '${translate(context, 'working_days')}',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              WeekdaySelector(
                elevation: 4,
                onChanged: (int day) {
                  if (day == 1) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .monday = !values[index] ? 1 : 0;
                  }
                  if (day == 2) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .tuesday = !values[index] ? 1 : 0;
                  }
                  if (day == 3) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .wednesday = !values[index] ? 1 : 0;
                  }
                  if (day == 4) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .thursday = !values[index] ? 1 : 0;
                  }
                  if (day == 5) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .friday = !values[index] ? 1 : 0;
                  }
                  if (day == 6) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .saturday = !values[index] ? 1 : 0;
                  }
                  if (day == 7) {
                    PharmacyRegisterationPage.pharmacyRequest.pharmacies[index]
                        .sunday = !values[index] ? 1 : 0;
                  }
                  setState(
                    () {
                      final index = day % 7;
                      values[index] = !values[index];
                    },
                  );
                },
                values: values,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('open_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        PharmacyRegisterationPage
                                .pharmacyRequest.pharmacies[index].openAt =
                            '${timeOfDay.hour}:${timeOfDay.minute}:00';
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('close_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        PharmacyRegisterationPage
                                .pharmacyRequest.pharmacies[index].closingAt =
                            '${timeOfDay.hour}:${timeOfDay.minute}:00';
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Text(
                '${translate(context, 'government')}',
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
                          _generalBloc.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();

                      cityList.clear();
                      currentGovernorate.cities.forEach((element) {
                        cityList.add(element.name);
                      });

                      selectedCity = cityList[0];

                      PharmacyRegisterationPage.pharmacyRequest
                          .pharmacies[index].city = num.parse(selectedCityId);
                      PharmacyRegisterationPage
                          .pharmacyRequest
                          .pharmacies[index]
                          .governorate = num.parse(selectedGovernorateId);

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
                          _generalBloc.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      PharmacyRegisterationPage.pharmacyRequest
                          .pharmacies[index].city = num.parse(selectedCityId);
                      PharmacyRegisterationPage
                          .pharmacyRequest
                          .pharmacies[index]
                          .governorate = num.parse(selectedGovernorateId);

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
                              List<LangPharmacist> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddPharmacyLangPage(
                                    title: langs[index].title,
                                    address: langs[index].address,
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
                      List<LangPharmacist> addedLangs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddPharmacyLangPage(),
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
                  ),
                ],
              ),
              
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndContineu(BuildContext context) {
    if (PharmacyRegisterationPage.pharmacyRequest.commercialName == null) {
      AppUtils.showToast(msg: translate(context, 'enter_commercial_name'));
      return;
    }
    if (PharmacyRegisterationPage.pharmacyRequest.description == null) {
      AppUtils.showToast(msg: translate(context, 'enter_description_of_you'));
      return;
    }
    if (PharmacyRegisterationPage.pharmacyRequest.description == null) {
      AppUtils.showToast(
          msg: translate(context, 'enter_short_description_of_you'));
      return;
    }
    for (int i = 0;
        i < PharmacyRegisterationPage.pharmacyRequest.pharmacies.length;
        i++) {
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].langs[i].title ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_the_title_of')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].langs[i].description ==
          null) {
        AppUtils.showToast(
            msg:
            '${translate(context, 'enter_the_description_of')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage
              .pharmacyRequest.pharmacies[i].deliveryStatus ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_delivery_status')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].coverImage ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_cover_image')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].logoImage ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_logo_image')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].gallery ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_photos_of')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].langs[i].address ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_the_address_of')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].phone ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_mobile_number_of')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].email != '') {
        if (!PatternUtils.emailIsValid(
            email: PharmacyRegisterationPage
                .pharmacyRequest.pharmacies[i].email)) {
          AppUtils.showToast(
              msg:
                  '${translate(context, 'enter_valid_email')} ${i + 1} ${translate(context, 'pharmacy')}');
          return;
        }
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].website !=
          '') {
        if (!PatternUtils.urlIsValid(
            url: PharmacyRegisterationPage
                .pharmacyRequest.pharmacies[i].website)) {
          AppUtils.showToast(
              msg:
                  '${translate(context, 'enter_valid_url')} ${i + 1} ${translate(context, 'pharmacy')}');
          return;
        }
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].openAt ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_time_of_opining')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
      if (PharmacyRegisterationPage.pharmacyRequest.pharmacies[i].openAt ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_time_of_closing')} ${i + 1} ${translate(context, 'pharmacy')}');
        return;
      }
    }

    pharmacyProvider.setCurrentIndicatorNumber(3);
  }
}
