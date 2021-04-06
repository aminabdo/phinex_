import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/restaurant/RestaurantCreateRequest.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/resturant_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'restaurant_regiteration_page.dart';

class RestaurantBussinesBody extends StatefulWidget {
  @override
  _RestaurantBussinesBodyState createState() => _RestaurantBussinesBodyState();
}

class _RestaurantBussinesBodyState extends State<RestaurantBussinesBody> {
  List<Widget> workshopsList = [];
  bool fillForm = false;

  @override
  void initState() {
    super.initState();

    RestaurantRegisterationPage.restaurantRequest.restaurants = [];
    RestaurantRegisterationPage.restaurantRequest.restaurants.add(Restaurant());
  }

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    if (!fillForm) {
      fillForm = true;
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
            RestaurantRegisterationPage.restaurantRequest.commercialName =
                input;
          },
        ),
        MyTextFormField(
          title: AppLocalization.of(context).translate('description'),
          maxLines: 5,
          onChanged: (String input) {
            RestaurantRegisterationPage.restaurantRequest.description = input;
          },
        ),
        MyTextFormField(
          title: translate(context, 'short_description'),
          maxLines: 3,
          onChanged: (String input) {
            RestaurantRegisterationPage.restaurantRequest.shortDescription =
                input;
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
            RestaurantRegisterationPage.restaurantRequest.restaurants
                .add(Restaurant());
            workshopsList.add(workshopForm(context, workshopsList.length,
                onDeleteBtnTapped: () {
              RestaurantRegisterationPage.restaurantRequest.restaurants
                  .removeAt(workshopsList.length - 1);
              workshopsList.removeAt(workshopsList.length - 1);

              setState(() {});
            }));
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
                translate(context, 'add_another_restaurant'),
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

  Widget workshopForm(BuildContext context, int index,
      {Function onDeleteBtnTapped}) {
    // We start with all days selected.
    final values = List.filled(7, false);

    List<String> deliveryStatusList = [
      translate(context, 'all_24_hours'),
      translate(context, 'as_open'),
      translate(context, 'none')
    ];

    List<String> governoratesList = [];
    List<String> cityList = [];

    String selectedGovernorate = '';
    String selectedGovernorateId = '';
    String selectedCity = '';
    String selectedCityId = '';

    String selectedDeliveryStatus = deliveryStatusList[0];

    if (selectedDeliveryStatus == deliveryStatusList[0]) {
      RestaurantRegisterationPage
          .restaurantRequest.restaurants[index].deliveryStatus = '24/7';
    } else if (selectedDeliveryStatus == deliveryStatusList[1]) {
      RestaurantRegisterationPage
          .restaurantRequest.restaurants[index].deliveryStatus = 'as_open';
    } else {
      RestaurantRegisterationPage
          .restaurantRequest.restaurants[index].deliveryStatus = 'none';
    }

    String coverImageResult = '';
    String profileImageResult = '';
    String photosResult = '';
    List<File> photos = [];
    File coverImage;
    File logoImage;

    RestaurantRegisterationPage.restaurantRequest.restaurants[index].saturday =
        0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].sunday = 0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].monday = 0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].tuesday =
        0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].wednesday =
        0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].thursday =
        0;
    RestaurantRegisterationPage.restaurantRequest.restaurants[index].friday = 0;

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

    RestaurantRegisterationPage.restaurantRequest.restaurants[index].city =
        num.parse(selectedCityId);
    RestaurantRegisterationPage.restaurantRequest.restaurants[index]
        .governorate = num.parse(selectedGovernorateId);

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
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: translate(context, 'title'),
                onChanged: (String input) {
                  RestaurantRegisterationPage
                      .restaurantRequest.restaurants[index].title = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: translate(context, 'phone'),
                keyboardType: TextInputType.phone,
                onChanged: (String input) {
                  RestaurantRegisterationPage.restaurantRequest
                      .restaurants[index].phone = int.parse(input);
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                maxLines: 5,
                onChanged: (String input) {
                  RestaurantRegisterationPage
                      .restaurantRequest.restaurants[index].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: translate(context, 'address'),
                onChanged: (String input) {
                  RestaurantRegisterationPage
                      .restaurantRequest.restaurants[index].address = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                onChanged: (String input) {
                  RestaurantRegisterationPage
                      .restaurantRequest.restaurants[index].email = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('website'),
                onChanged: (String input) {
                  RestaurantRegisterationPage
                      .restaurantRequest.restaurants[index].website = input;
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
                        RestaurantRegisterationPage.restaurantRequest
                            .restaurants[index].deliveryStatus = '24/7';
                      } else if (selectedDeliveryStatus ==
                          deliveryStatusList[1]) {
                        RestaurantRegisterationPage.restaurantRequest
                            .restaurants[index].deliveryStatus = 'as_open';
                      } else {
                        RestaurantRegisterationPage.restaurantRequest
                            .restaurants[index].deliveryStatus = 'none';
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
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].coverImage = coverImage;

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
                    RestaurantRegisterationPage
                        .restaurantRequest.restaurants[index].logo = logoImage;

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

                    RestaurantRegisterationPage
                        .restaurantRequest.restaurants[index].gallery = photos;
                    photosResult =
                        '${photos.length} ${photos.length == 1 ? translate(context, 'image') : translate(context, 'images')}';
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
                                          '${photos.length} ${photos.length == 1 ? translate(context, 'image') : translate(context, 'images')}';
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
                translate(context, 'working_days'),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              WeekdaySelector(
                elevation: 4,
                onChanged: (int day) {
                  if (day == 1) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].monday = !values[index] ? 1 : 0;
                  }
                  if (day == 2) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].tuesday = !values[index] ? 1 : 0;
                  }
                  if (day == 3) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].wednesday = !values[index] ? 1 : 0;
                  }
                  if (day == 4) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].thursday = !values[index] ? 1 : 0;
                  }
                  if (day == 5) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].friday = !values[index] ? 1 : 0;
                  }
                  if (day == 6) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].saturday = !values[index] ? 1 : 0;
                  }
                  if (day == 7) {
                    RestaurantRegisterationPage.restaurantRequest
                        .restaurants[index].sunday = !values[index] ? 1 : 0;
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
                        RestaurantRegisterationPage
                                .restaurantRequest.restaurants[index].openAt =
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
                        RestaurantRegisterationPage.restaurantRequest
                                .restaurants[index].closingAt =
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
                'Government',
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

                      RestaurantRegisterationPage.restaurantRequest
                          .restaurants[index].city = num.parse(selectedCityId);
                      RestaurantRegisterationPage
                          .restaurantRequest
                          .restaurants[index]
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

                      RestaurantRegisterationPage.restaurantRequest
                          .restaurants[index].city = num.parse(selectedCityId);
                      RestaurantRegisterationPage
                          .restaurantRequest
                          .restaurants[index]
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
            ],
          ),
        ),
      ),
    );
  }

  void validateAndContineu(BuildContext context) {
    if (RestaurantRegisterationPage.restaurantRequest.commercialName == null) {
      AppUtils.showToast(msg: translate(context, 'enter_commercial_name'));
      return;
    }
    if (RestaurantRegisterationPage.restaurantRequest.description == null) {
      AppUtils.showToast(msg: translate(context, 'enter_description_of_you'));
      return;
    }
    if (RestaurantRegisterationPage.restaurantRequest.description == null) {
      AppUtils.showToast(
          msg: translate(context, 'enter_short_description_of_you'));
      return;
    }
    for (int i = 0;
        i < RestaurantRegisterationPage.restaurantRequest.restaurants.length;
        i++) {
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].title ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'enter_the_title_of')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage
              .restaurantRequest.restaurants[i].deliveryStatus ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_delivery_status')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage
              .restaurantRequest.restaurants[i].coverImage ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_cover_image')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].logo ==
          null) {
        AppUtils.showToast(
            msg:
                '${translate(context, 'select_logo_image')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].gallery == null) {
        AppUtils.showToast(msg: '${translate(context, 'select_photos_of')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].address == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_the_address_of')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].phone == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_mobile_number_of')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].email != '') {
        if (!PatternUtils.emailIsValid(email: RestaurantRegisterationPage.restaurantRequest.restaurants[i].email)) {
          AppUtils.showToast(msg: '${translate(context, 'enter_valid_email')} ${i + 1} ${translate(context, 'restaurant')}');
          return;
        }
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].website != '') {
        if (!PatternUtils.urlIsValid(url: RestaurantRegisterationPage.restaurantRequest.restaurants[i].website)) {
          AppUtils.showToast(msg: '${translate(context, 'enter_valid_url')} ${i + 1} ${translate(context, 'restaurant')}');
          return;
        }
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].openAt == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_opining')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
      if (RestaurantRegisterationPage.restaurantRequest.restaurants[i].openAt == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_closing')} ${i + 1} ${translate(context, 'restaurant')}');
        return;
      }
    }

    resturantProvider.setCurrentIndicatorNumber(3);
  }
}
