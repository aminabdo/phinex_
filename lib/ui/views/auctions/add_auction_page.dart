import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateAuctionFormRequest.dart';
import 'package:phinex/Bles/Model/responses/auctions/AuctionLandingResponse.dart';
import 'package:phinex/Bles/bloc/auction/AuctionBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_date_picker.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'create_aution_lang_page.dart';

class AddAuctionPage extends StatefulWidget {
  @override
  _AddAuctionPageState createState() => _AddAuctionPageState();
}

class _AddAuctionPageState extends State<AddAuctionPage> {
  List<File> photos = [];
  List<String> categoriesList = [];

  File coverImage;
  File logoImage;

  bool isLoading = false;
  bool gotData = false;

  String coverImageResult = '';
  String profileImageResult = '';
  String photosResult = '';
  DateTime endD;
  DateTime openD;
  String endTime;
  String openTime;
  String openDate;
  String endDate;
  TimeOfDay openT;
  TimeOfDay endT;
  String selectedCategory = 'A';

  String titleErrorMsg = '';
  String endTimeErrorMsg = '';
  String openTimeErrorMsg = '';
  String endDateErrorMsg = '';
  String openDateErrorMsg = '';
  String openPriceErrorMsg = '';
  String incrementValueErrorMsg = '';
  String coverImageErrorMsg = '';
  String photosErrorMsg = '';
  String descriptionErrorMsg = '';

  CreateAuctionFormRequest auctionRequest = CreateAuctionFormRequest();

  List<LangAuction> langs = [];

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  void initState() {
    super.initState();

    print(AppUtils.userData.apiToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(translate(context, 'add_auction'), context),
      body: StreamBuilder<AuctionLandingResponse>(
        stream: auctionBloc.landing.stream,
        builder: (context, snapshot) {
          if (auctionBloc.loading.value) {
            return Loader();
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              if (!gotData) {

                gotData = true;

                langs.add(LangAuction(
                  lang: AppUtils.language,
                ));

                snapshot.data.data.forEach((element) {
                  categoriesList.add(element.name);
                });

                selectedCategory = categoriesList.isNotEmpty ? categoriesList[0] : '';
                snapshot.data.data.forEach((element) {
                  if (element.name == selectedCategory) {
                    auctionRequest.categoryId = element.id.toString();
                  }
                });
              }
            }
            return LoadingOverlay(
              isLoading: isLoading,
              opacity: .5,
              progressIndicator: Loader(),
              color: Colors.white,
              child: SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        title: translate(context, 'title'),
                        errorMessage: titleErrorMsg,
                        onChanged: (String input) {
                          langs[0].title = input;
                        },
                      ),
                      Text(
                        translate(context, 'auction_category'),
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
                            onChanged: (result) {
                              selectedCategory = result;
                              auctionRequest.categoryId = snapshot.data.data
                                  .firstWhere((element) => element.name == selectedCategory).id.toString();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(25),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyDatePicker(
                                  title: translate(context, 'open_date'),
                                  firstDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  onDateSelected: (String date, DateTime dateSelected) {
                                    openD = dateSelected;
                                    openDate = '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
                                  },
                                ),
                                Text(
                                  openDateErrorMsg ?? '',
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
                                  firstDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  title: translate(context, 'close_date'),
                                  onDateSelected: (String date, DateTime dateSelected) {
                                    if(openD != null) {
                                      if(openD.isAfter(dateSelected)) {
                                        endDateErrorMsg = AppUtils.translate(context, 'invalid_date_msg');
                                        setState(() {});
                                        return;
                                      }
                                    }

                                    endD = dateSelected;
                                    endDate = '${dateSelected.year}-${dateSelected.month}-${dateSelected.day}';
                                  },
                                ),
                                Text(
                                  endDateErrorMsg ?? '',
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
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyTimePicker(
                                  title: translate(context, 'open_time'),
                                  onTimeSelected: (String time, TimeOfDay timeOfDay) {
                                    openTime = '${timeOfDay.hour}:${timeOfDay.minute}:00';
                                    openT = timeOfDay;
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
                                MyTimePicker(
                                  title: translate(context, 'close_time'),
                                  onTimeSelected: (String time, TimeOfDay timeOfDay) {
                                    if(openTime != null) {
                                      var dateNow = DateTime.now();
                                      DateTime endT = DateTime(dateNow.year, dateNow.month, dateNow.day, timeOfDay.hour, timeOfDay.minute, 00);
                                      DateTime startT = DateTime(dateNow.year, dateNow.month, dateNow.day, openT.hour, openT.minute, 00);
                                      if(startT.isAfter(endT)) {
                                        endTimeErrorMsg = AppUtils.translate(context, 'invalid_time_msg');
                                        setState(() {});

                                        return;
                                      }
                                    }

                                    endT = timeOfDay;
                                    endTime = '${timeOfDay.hour}:${timeOfDay.minute}:00';
                                  },
                                ),
                                Text(endTimeErrorMsg ?? '',
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
                      MyTextFormField(
                        title: translate(context, 'open_price'),
                        keyboardType: TextInputType.number,
                        errorMessage: openPriceErrorMsg,
                        onChanged: (String input) {
                          auctionRequest.openPrice = input;
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      MyTextFormField(
                        title: translate(context, 'increment_value'),
                        keyboardType: TextInputType.number,
                        errorMessage: incrementValueErrorMsg,
                        onChanged: (String input) {
                          auctionRequest.incrementValue = input;
                          print(auctionRequest.incrementValue);
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      MyUploadImageButton(
                        title: translate(context, 'cover_image'),
                        result: profileImageResult,
                        onTap: () async {
                          var selectedImage = await AppUtils.getImage(1);
                          if (selectedImage != null) {
                            var path =
                                await FlutterAbsolutePath.getAbsolutePath(
                              selectedImage[0].identifier,
                            );

                            logoImage = File(path);
                            auctionRequest.mainImage = logoImage;

                            String name = basename(path);
                            profileImageResult = name;
                            setState(() {});
                          }
                        },
                      ),
                      Text(
                        coverImageErrorMsg ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
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

                            auctionRequest.gallery = photos;
                            photosResult =
                                '${photos.length} ${photos.length == 1 ? translate(context, 'image') : translate(context, 'images')}';
                            setState(() {});
                          }
                        },
                      ),
                      Text(
                        photosErrorMsg ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 12),
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
                                              photosResult = '${photos.length} ${photos.length == 1 ? translate(context, 'image') : translate(context, 'images')}';
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
                      MyTextFormField(
                        title: translate(context, 'description'),
                        errorMessage: descriptionErrorMsg,
                        maxLines: 5,
                        onChanged: (String input) {
                          langs[0].description = input;
                        },
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
                                      List<LangAuction> addedLangs =
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CreateAuctionLangPage(
                                            title: langs[index].title,
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
                              List<LangAuction> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateAuctionLangPage(),
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
                        translate(context, 'add_auction'),
                        onTap: () {
                          validateAndCreateAuction(context);
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(15),
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

  void validateAndCreateAuction(BuildContext context) async {
    // title
    if (langs[0].title == null || langs[0].title.isEmpty) {
      titleErrorMsg = translate(context, 'required');
    } else {
      titleErrorMsg = null;
    }

    // open date
    if (openDate == null || openDate.isEmpty) {
      openDateErrorMsg = translate(context, 'required');
    } else {
      openDateErrorMsg = null;
    }

    // open time
    if (openTime == null || openTime.isEmpty) {
      openTimeErrorMsg = translate(context, 'required');
    } else {
      openTimeErrorMsg = null;
    }

    // end date
    if (endDate == null || endDate.isEmpty) {
      endDateErrorMsg = translate(context, 'required');
    } else {
      if(openD.isAfter(endD)) {
        endDateErrorMsg = AppUtils.translate(context, 'invalid_date_msg');
      } else {
        endDateErrorMsg = null;
      }
    }

    // end time
    if (endTime == null || endTime.isEmpty) {
      endTimeErrorMsg = translate(context, 'required');
    } else {
      var dateNow = DateTime.now();
      DateTime endT = DateTime(dateNow.year, dateNow.month, dateNow.day, this.endT.hour, this.endT.minute, 00);
      DateTime startT = DateTime(dateNow.year, dateNow.month, dateNow.day, openT.hour, openT.minute, 00);
      if(startT.isAfter(endT)) {
        endTimeErrorMsg = AppUtils.translate(context, 'invalid_time_msg');
      } else {
        endTimeErrorMsg = null;
      }
    }

    // open price
    if (auctionRequest.openPrice == null) {
      openPriceErrorMsg = translate(context, 'required');
    } else if (double.parse(auctionRequest.openPrice) <= 0) {
      openPriceErrorMsg = translate(context, 'invalid_value');
    } else {
      openPriceErrorMsg = null;
    }

    // increment value
    if (auctionRequest.incrementValue == null) {
      incrementValueErrorMsg = translate(context, 'required');
    } else if (double.parse(auctionRequest.incrementValue) <= 0) {
      incrementValueErrorMsg = translate(context, 'invalid_value');
    } else {
      incrementValueErrorMsg = null;
    }

    // main image
    if (auctionRequest.mainImage == null) {
      coverImageErrorMsg = translate(context, 'required');
    } else {
      coverImageErrorMsg = null;
    }

    // gallery
    if (auctionRequest.gallery == null || auctionRequest.gallery.isEmpty) {
      photosErrorMsg = translate(context, 'required');
    } else {
      photosErrorMsg = null;
    }

    // description
    if (langs[0].description == null) {
      descriptionErrorMsg = translate(context, 'required');
    } else {
      descriptionErrorMsg = null;
    }

    print(auctionRequest.toString());

    setState(() {});

    if (titleErrorMsg == null &&
        openDate != null &&
        openTime != null &&
        openPriceErrorMsg == null &&
        incrementValueErrorMsg == null &&
        coverImageErrorMsg == null &&
        photosErrorMsg == null &&
        descriptionErrorMsg == null &&
        endDateErrorMsg == null &&
        endTimeErrorMsg == null) {
      // everything is true
      auctionRequest.opensFrom = openDate + ' ' + openTime;
      auctionRequest.endsAt = endDate + ' ' + endTime;
      auctionRequest.sellerId = AppUtils.userData.id.toString();
      auctionRequest.lang = langs;

      isLoading = true;
      setState(() {});

      var response = await auctionBloc.createAuction(auctionRequest);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        AppUtils.showToast(
            msg: translate(context, 'auction_created_successfully'),
            bgColor: mainColor,
        );
        isLoading = false;
        setState(() {});
        Navigator.pop(context);

      } else {
        isLoading = false;
        setState(() {});
        AppUtils.showToast(
          msg: response.statusMessage,
        );
      }
    }
  }
}
