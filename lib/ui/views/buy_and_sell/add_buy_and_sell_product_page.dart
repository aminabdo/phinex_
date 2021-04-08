import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/BuySellFormRequest.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateAuctionFormRequest.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/auction/AuctionBloc.dart';
import 'package:phinex/Bles/bloc/buy_sell/BuySellBloc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/widgets/done_dialog.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_date_picker.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:path/path.dart';

import 'add_buy_sell_lang_page.dart';

class AddBuySellProductPage extends StatefulWidget {
  @override
  _AddBuySellProductPageState createState() => _AddBuySellProductPageState();
}

class _AddBuySellProductPageState extends State<AddBuySellProductPage> {
  String selectedCategory = '';
  String selectedCategoryId = '';

  List<String> categories = [];
  File logoImage;
  List<File> photos = [];
  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> priceTypeList = [];

  List<LangBuySellBean> langs = [];
  List<LangAuction> auctionLangs = [];

  String selectedCategoryErrorMsg = '';
  String businessActivityErrorMsg = '';
  String priceErrorMsg = '';
  String coverErrorMsg = '';
  String phoneErrorMsg = '';
  String titleErrorMsg = '';
  String photosErrorMsg = '';
  String incrementValueErrorMsg = '';
  String cityErrorMsg = '';
  String governmentErrorMsg = '';
  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String addressErrorMsg;

  TextEditingController cityController = TextEditingController();
  TextEditingController governmentController = TextEditingController();
  TextEditingController businessActivityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController incrementValueController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String companyLogoResult = '';
  String photosResult = '';
  String selectedPriceType = '';

  bool gotCategory = false;
  bool isLoading = false;
  bool doneStatus = false;
  bool gotData = false;

  String openDate;
  String endDate;

  String openTimeErrorMsg;
  String endTimeErrorMsg;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  getData(BuildContext context) {
    buySellBloc.create.stream.listen(
      (value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          isLoading = false;
          setState(() {});
          showDialog(
            context: context,
            builder: (_) => DoneDialogContent(
              msg: translate(context, 'product_added_successfully'),
            ),
          );
        } else {
          isLoading = false;
          setState(() {});
          AppUtils.showToast(msg: value.data['message']);
        }
      },
    );
  }

  getDataAuction(BuildContext context) {
    // auctionBloc.create.stream.listen(
    //   (value) {
    //     if (value.statusCode >= 200 && value.statusCode < 300) {
    //       isLoading = false;
    //       setState(() {});
    //       showDialog(
    //         context: context,
    //         builder: (_) => DoneDialogContent(
    //           msg: translate(context, 'product_added_successfully'),
    //         ),
    //       );
    //     } else {
    //       isLoading = false;
    //       setState(() {});
    //       AppUtils.showToast(msg: value.data['message']);
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    priceTypeList = [
      AppUtils.translate(
        context,
        'fixed_price',
      ),
      AppUtils.translate(
        context,
        'highest_price',
      )
    ];

    if (!doneStatus) {
      doneStatus = true;
      buySellBloc.create.onListen = getData(context);
      // auctionBloc.create.onListen = getDataAuction(context);
      selectedPriceType = priceTypeList[0];
      langs.add(
        LangBuySellBean(
          lang: AppUtils.language,
        ),
      );
    }

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'add_product'),
        context,
      ),
      body: StreamBuilder<BuySellLandingResponse>(
        stream: buySellBloc.landing.stream,
        builder: (context, snapshot) {
          if (buySellBloc.loading.value) {
            return Loader();
          } else {
           if(snapshot.hasData && snapshot.data != null) {
             snapshot.data.data.categories
                 ?.forEach((element) {
               if (!categories.contains(element.name)) {
                 categories.add(element.name);
               }
             });

             if (!gotCategory) {
               gotCategory = true;
               selectedCategory = categories.isNotEmpty ? categories[0] : '';
             }
           }
            return StreamBuilder<GeneralModelGovResponse>(
              stream: generalBloc.generalGovModel.stream,
              builder: (context, snapshot) {
                if (generalBloc.loading.value) {
                  return Loader();
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    if(!gotData) {

                      snapshot.data.data.governorates.forEach((element) {
                        governoratesList.add(element.name);
                      });

                      selectedGovernorate = governoratesList[0];

                      var government = snapshot.data.data.governorates
                          .firstWhere(
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

                      gotData = true;
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
                                translate(context, 'category'),
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                selectedCategoryErrorMsg,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              Text(
                                translate(context, 'price'),
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
                                    value: selectedPriceType,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.grey,
                                      size: 26,
                                    ),
                                    items: priceTypeList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      selectedPriceType = newValue;
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
                              // fixed price
                              MyTextFormField(
                                title: translate(
                                        context,
                                        selectedPriceType == priceTypeList[0]
                                            ? 'price'
                                            : 'start_price')
                                    .toUpperCase(),
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                errorMessage: priceErrorMsg,
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
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              //
                              selectedPriceType == priceTypeList[1]
                                  ? MyTextFormField(
                                      title:
                                          translate(context, 'increment_value')
                                              .toUpperCase(),
                                      controller: incrementValueController,
                                      keyboardType: TextInputType.number,
                                      errorMessage: incrementValueErrorMsg,
                                      onChanged: (String input) {
                                        if (input.isEmpty) {
                                          incrementValueErrorMsg =
                                              AppLocalization.of(context)
                                                  .translate("required");
                                        } else {
                                          incrementValueErrorMsg = null;
                                        }
                                        setState(() {});
                                      },
                                    )
                                  : SizedBox.shrink(),
                              selectedPriceType == priceTypeList[1]
                                  ? SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    )
                                  : SizedBox.shrink(),
                              MyTextFormField(
                                title: translate(context, 'title0'),
                                controller: titleController,
                                errorMessage: titleErrorMsg,
                                onChanged: (String input) {
                                  if (input.isEmpty) {
                                    titleErrorMsg = AppLocalization.of(context)
                                        .translate("required");
                                  } else {
                                    titleErrorMsg = null;
                                  }
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              MyTextFormField(
                                title: translate(context, 'mobile_number'),
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
                              MyUploadImageButton(
                                title: translate(context, 'logo_image'),
                                result: companyLogoResult,
                                onTap: () async {
                                  bool permissionIsGranted =
                                      await AppUtils.askPhotosPermission();
                                  if (permissionIsGranted) {
                                    try {
                                      var resultList =
                                          await MultiImagePicker.pickImages(
                                        maxImages: 1,
                                        cupertinoOptions: CupertinoOptions(
                                            takePhotoIcon: APP_NAME),
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
                                      var path = await FlutterAbsolutePath
                                          .getAbsolutePath(
                                        resultList[0].identifier,
                                      );

                                      logoImage = File(path);

                                      // print file name
                                      String name = basename(path);
                                      companyLogoResult = name;
                                      setState(() {});
                                    } on Exception catch (e) {
                                      print(e.toString());
                                    }
                                  } else {
                                    AppUtils.showToast(
                                        msg: 'Accept Permission first');
                                  }
                                },
                              ),
                              Text(
                                coverErrorMsg,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
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
                                        cupertinoOptions: CupertinoOptions(
                                            takePhotoIcon: APP_NAME),
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

                                      for (int i = 0;
                                          i < resultList.length;
                                          i++) {
                                        photos.add(
                                          File(
                                            await FlutterAbsolutePath
                                                .getAbsolutePath(
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
                                photosErrorMsg,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
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
                                                width:
                                                    ScreenUtil().setWidth(100),
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
                                                margin:
                                                    EdgeInsets.only(right: 8),
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
                                height: ScreenUtil()
                                    .setHeight(photos.isEmpty ? 5 : 15),
                              ),
                              selectedPriceType == priceTypeList[1] ? Column(
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyDatePicker(
                                              title: translate(context, 'open_date'),
                                              onDateSelected:
                                                  (String date, DateTime dateSelected) {
                                                openDate = '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
                                              },
                                            ),
                                            Text(
                                              openTimeErrorMsg ?? '',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
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
                                            MyDatePicker(
                                              title: translate(context, 'end_date'),
                                              onDateSelected:
                                                  (String date, DateTime dateSelected) {
                                                endDate = '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
                                              },
                                            ),
                                            Text(
                                              endTimeErrorMsg ?? '',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                ],
                              ) : SizedBox.shrink(),
                              selectedPriceType == priceTypeList[0]
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          translate(context, 'government'),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(12),
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffEEEEEE),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: selectedGovernorate,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Colors.grey,
                                                size: 26,
                                              ),
                                              items: governoratesList
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: new Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                selectedGovernorate = newValue;
                                                var currentGovernorate =
                                                    snapshot
                                                        .data.data.governorates
                                                        .firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      selectedGovernorate,
                                                );

                                                selectedGovernorateId =
                                                    currentGovernorate.id
                                                        .toString();

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
                                            horizontal:
                                                ScreenUtil().setWidth(12),
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffEEEEEE),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: selectedCity,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Colors.grey,
                                                size: 26,
                                              ),
                                              items:
                                                  cityList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: new Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                selectedCity = newValue;
                                                var currentGovernorate =
                                                    snapshot
                                                        .data.data.governorates
                                                        .firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      selectedGovernorate,
                                                );

                                                currentGovernorate.cities
                                                    .forEach((element) {
                                                  if (element.name ==
                                                      selectedCity) {
                                                    selectedCityId =
                                                        element.id.toString();
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
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              MyTextFormField(
                                title: translate(context, 'address'),
                                keyboardType: TextInputType.text,
                                errorMessage: addressErrorMsg,
                                controller: addressController,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              MyTextFormField(
                                title: translate(context, 'business_activity'),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                errorMessage: businessActivityErrorMsg,
                                controller: businessActivityController,
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
                                              List<LangBuySellBean> addedLangs =
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => AddBuySellLangPage(
                                                    title: langs[index].title,
                                                    address: langs[index].address,
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
                                    onTap: langs.length >= 2 ? null :  () async {
                                      List<LangBuySellBean> addedLangs =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddBuySellLangPage(),
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
                                translate(context, 'add_product'),
                                btnColor: mainColor,
                                onTap: () {
                                  createNewProduct(context);
                                },
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Loader();
                }
              },
            );
          }
        },
      ),
    );
  }

  void createNewProduct(BuildContext context) async {
    AppUtils.hideKeyboard(context);

    // category
    if (selectedCategory == '') {
      selectedCategoryErrorMsg = translate(context, 'required');
    }

    // logo image
    if (logoImage == null) {
      coverErrorMsg = translate(context, 'required');
    }

    // photos
    if (photos.isEmpty || photos.length == 0) {
      photosErrorMsg = translate(context, 'required');
    }

    // title
    if (titleController.text.isEmpty) {
      titleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      titleErrorMsg = translate(context, 'invalid_length');
    } else {
      titleErrorMsg = null;
    }

    // address
    if (addressController.text.isEmpty) {
      addressErrorMsg = AppLocalization.of(context).translate("required");
    } else if (addressController.text.length < 2) {
      addressErrorMsg = translate(context, 'invalid_length');
    } else {
      addressErrorMsg = null;
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
    if (businessActivityController.text.isEmpty) {
      businessActivityErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (businessActivityController.text.length < 2) {
      businessActivityErrorMsg = translate(context, 'invalid_length');
    } else {
      businessActivityErrorMsg = null;
    }

    // price
    if (priceController.text.isEmpty) {
      priceErrorMsg = AppLocalization.of(context).translate("required");
    } else if (num.tryParse(priceController.text) < 0) {
      priceErrorMsg = AppUtils.translate(context, 'invalid_price');
    } else {
      priceErrorMsg = null;
    }

    if (selectedPriceType != priceTypeList[0]) {
      // price
      if (incrementValueController.text.isEmpty) {
        incrementValueErrorMsg =
            AppLocalization.of(context).translate("required");
      } else if (num.tryParse(priceController.text) < 0) {
        incrementValueErrorMsg = AppUtils.translate(context, 'invalid_price');
      } else {
        incrementValueErrorMsg = null;
      }
    }

    setState(() {});

    // normal buy sell action
    print(selectedPriceType);
    if (selectedPriceType == priceTypeList[0]) {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  11');
      if (businessActivityErrorMsg == null &&
          priceErrorMsg == null &&
          titleErrorMsg == null &&
          phoneErrorMsg == null &&
          addressErrorMsg == null &&
          logoImage != null &&
          photos.isNotEmpty) {


        buySellBloc.landing.value?.data?.categories?.forEach((element) {
          if (selectedCategory == element.name) {
            selectedCategoryId = element.id.toString();
          }
        });

        langs[0].title = titleController.text;
        langs[0].address = addressController.text;
        langs[0].description = businessActivityController.text;

        var request = BuySellFormRequest(
          categoryId: selectedCategoryId,
          city: selectedCityId,
          governorate: selectedGovernorateId,
          phone: phoneController.text,
          price: priceController.text,
          main_image: logoImage,
          gallery: photos,
          sellerId: AppUtils.userData?.id.toString(),
          status: 'pending',
          country: AppUtils.getCountryId(),
          langs: langs,
        );

        print("request");
        print(request.toJson());

        isLoading = true;
        setState(() {});
        print(phoneController.text);
        buySellBloc.createBuy(request);
      }
    } else {
      // auction request
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  22');
      if (businessActivityErrorMsg == null &&
          priceErrorMsg == null &&
          incrementValueErrorMsg == null &&
          titleErrorMsg == null &&
          phoneErrorMsg == null &&
          addressErrorMsg == null &&
          logoImage != null &&
          photos.isNotEmpty) {

        if(openDate == null) {
          AppUtils.showToast(msg: '${AppUtils.translate(context, 'open_date')} ${AppUtils.translate(context, 'required')}');
          return;
        }


        if(endDate == null) {
          AppUtils.showToast(msg: '${AppUtils.translate(context, 'end_date')} ${AppUtils.translate(context, 'required')}');
          return;
        }

        buySellBloc.landing.value?.data?.categories?.forEach((element) {
          if (selectedCategory == element.name) {
            selectedCategoryId = element.id.toString();
          }
        });

        isLoading = true;
        setState(() {});

        var request = CreateAuctionFormRequest(
          endsAt: endDate,
          status: 'pending',
          isVip: '0',
          opensFrom: openDate,
          incrementValue: (incrementValueController.text),
          categoryId: (selectedCategoryId),
          mainImage: logoImage,
          gallery: photos,
          sellerId: AppUtils.userData?.id.toString(),
          openPrice: (priceController.text),
          lang: auctionLangs
        );

        // auctionBloc.createAuction(request);
      }
    }
  }
}
