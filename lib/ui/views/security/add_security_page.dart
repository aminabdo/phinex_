

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateCalalougeFormRequest.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/catalogue/CatalogueBloc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/views/companies_index/add_index_lang_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:path/path.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class AddSecurityPage extends StatefulWidget {
  @override
  _AddSecurityPageState createState() => _AddSecurityPageState();
}

class _AddSecurityPageState extends State<AddSecurityPage> {
  String selectedCategory = 'A';
  String emailErrorMsg = '';
  String websiteErrorMsg = '';
  String phoneErrorMsg = '';
  String cityErrorMsg = '';
  String governmentErrorMsg = '';
  String categoryErrorMsg = '';
  String businessActivityErrorMsg = '';
  String titleErrorMsg = '';
  String addressErrorMsg = '';
  String businessDescriptionErrorMsg = '';
  String descriptionErrorMsg = '';

  List<String> categories = [];

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  List<String> governoratesList = [];
  List<String> cityList = [];

  bool gotData = false;
  bool gotData2 = false;
  bool isLoading = false;

  String profileImageResult = '';
  String profileImageErrorMsg;
  String photosResult = '';
  String photosErrorMsg;
  List<File> photos = [];
  File profileImage;

  List<LangCatalouge> langs = [];

  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController governmentController = TextEditingController();
  TextEditingController businessActivityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController businessDescriptionContrller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        translate(context, 'add_new'),
        context,
      ),
      body: Center(
        child: LoadingOverlay(
          isLoading: isLoading,
          progressIndicator: Loader(),
          color: Colors.white,
          opacity: .5,
          child: StreamBuilder<CatalogueLandingResponse>(
            stream: catalogueBloc.landing.stream,
            builder: (context, snapshot) {
              if (catalogueBloc.loading.value) {
                return Loader();
              } else {
                if (!gotData) {
                  catalogueBloc.landing.value.data.forEach((element) {
                    categories.add(element.name);
                  });

                  selectedCategory = categories[0];

                  langs.add(
                    LangCatalouge(
                      lang: AppUtils.language,
                    ),
                  );

                  gotData = true;
                }
                return StreamBuilder<GeneralModelGovResponse>(
                  stream: generalBloc.generalGovModel.stream,
                  builder: (context, snapshot) {
                    if (generalBloc.loading.value) {
                      return Loader();
                    } else {
                      if (snapshot.hasData && snapshot.data != null) {
                        if (!gotData2) {
                          snapshot.data.data.governorates.forEach((element) {
                            governoratesList.add(element.name);
                          });

                          selectedGovernorate = governoratesList[0];

                          var government = snapshot.data.data.governorates
                              .firstWhere((element) =>
                          element.name == selectedGovernorate);
                          government.cities.forEach((element) {
                            cityList.add(element.name);
                          });

                          selectedCity = cityList[0];

                          var currentGovernorate =
                          snapshot.data.data.governorates.firstWhere(
                                (element) => element.name == selectedGovernorate,
                          );

                          selectedGovernorateId =
                              currentGovernorate.id.toString();

                          currentGovernorate.cities.forEach(
                                (element) {
                              if (element.name == selectedCity) {
                                selectedCityId = element.id.toString();
                              }
                            },
                          );

                          gotData2 = true;
                        }
                      }
                      return Padding(
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
                                AppLocalization.of(context)
                                    .translate('category'),
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
                              Text(
                                categoryErrorMsg,
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              MyTextFormField(
                                title: AppLocalization.of(context)
                                    .translate('title'),
                                controller: titleController,
                                errorMessage: titleErrorMsg,
                              ),
                              MyTextFormField(
                                title: AppLocalization.of(context)
                                    .translate('email'),
                                errorMessage: emailErrorMsg,
                                controller: emailController,
                              ),
                              MyTextFormField(
                                title: AppLocalization.of(context)
                                    .translate('mobile_number'),
                                errorMessage: phoneErrorMsg,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(10),
                              ),
                              MyUploadImageButton(
                                title: translate(context, 'logo_image'),
                                result: profileImageResult,
                                onTap: () async {
                                  var selectedImage =
                                  await AppUtils.getImage(1);
                                  if (selectedImage != null) {
                                    var path = await FlutterAbsolutePath
                                        .getAbsolutePath(
                                      selectedImage[0].identifier,
                                    );

                                    profileImage = File(path);

                                    String name = basename(path);
                                    profileImageResult = name;
                                    setState(() {});
                                  }
                                },
                              ),
                              Text(
                                profileImageErrorMsg ?? '',
                                style:
                                TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(25),
                              ),
                              MyUploadImageButton(
                                title: translate(context, 'photos'),
                                result: photosResult,
                                onTap: () async {
                                  List<Asset> resultList =
                                  await AppUtils.getImage(10);
                                  if (resultList != null) {
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
                                  }
                                },
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(5),
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
                              Text(
                                photosErrorMsg ?? '',
                                style:
                                TextStyle(color: Colors.red, fontSize: 12),
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(10),
                              ),
                              MyTextFormField(
                                title: AppLocalization.of(context)
                                    .translate('address'),
                                errorMessage: addressErrorMsg,
                                controller: addressController,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
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
                                      var currentGovernorate = snapshot
                                          .data.data.governorates
                                          .firstWhere(
                                            (element) =>
                                        element.name == selectedGovernorate,
                                      );

                                      selectedGovernorateId =
                                          currentGovernorate.id.toString();

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
                                      var currentGovernorate = snapshot
                                          .data.data.governorates
                                          .firstWhere(
                                            (element) =>
                                        element.name == selectedGovernorate,
                                      );

                                      currentGovernorate.cities
                                          .forEach((element) {
                                        if (element.name == selectedCity) {
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
                              MyTextFormField(
                                title:
                                AppUtils.translate(context, 'description'),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                errorMessage: descriptionErrorMsg,
                                controller: descriptionController,
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(10),
                              ),
                              MyTextFormField(
                                title: AppUtils.translate(
                                    context, 'business_activity'),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                errorMessage: businessActivityErrorMsg,
                                controller: businessActivityController,
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(10),
                              ),
                              MyTextFormField(
                                title: AppUtils.translate(
                                    context, 'business_description'),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                errorMessage: businessDescriptionErrorMsg,
                                controller: businessDescriptionContrller,
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(10),
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
                                              List<LangCatalouge> addedLangs =
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddCatalougeLangPage(
                                                        title: langs[index].title,
                                                        businessActivity:
                                                        langs[index]
                                                            .business_activity,
                                                        lang: langs[index].lang,
                                                        descriptionActivity: langs[
                                                        index]
                                                            .business_description,
                                                        description: langs[index]
                                                            .description,
                                                        address:
                                                        langs[index].address,
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
                                    onTap: langs.length >= 2
                                        ? null
                                        : () async {
                                      List<LangCatalouge> addedLangs =
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddCatalougeLangPage(),
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
                                          translate(
                                              context, 'add_another_language'),
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
                                AppUtils.translate(context, 'add_new'),
                                btnColor: mainColor,
                                onTap: () {
                                  validateAndCreateNew(context);
                                },
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(20),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void validateAndCreateNew(BuildContext context) async {
    AppUtils.hideKeyboard(context);

    // title
    if (titleController.text.isEmpty) {
      titleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      titleErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      titleErrorMsg = null;
    }

    // main image
    if (profileImage == null) {
      profileImageErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      profileImageErrorMsg = null;
    }

    // photos
    if (photos == null || photos.isEmpty) {
      photosErrorMsg = AppLocalization.of(context).translate("required");
    } else {
      photosErrorMsg = null;
    }

    // address
    if (addressController.text.isEmpty) {
      addressErrorMsg = AppLocalization.of(context).translate("required");
    } else if (addressController.text.length < 2) {
      addressErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      addressErrorMsg = null;
    }

    // business Activity
    if (businessActivityController.text.isEmpty) {
      websiteErrorMsg = translate(context, 'required');
    } else {
      websiteErrorMsg = null;
    }

    if (emailController.text.isEmpty) {
      if (!PatternUtils.emailIsValid(email: emailController.text)) {
        emailErrorMsg = translate(context, 'enter_valid_email');
      } else {
        emailErrorMsg = null;
      }
    } else {
      emailErrorMsg = null;
    }

    // mobile number
    if (phoneController.text.isEmpty) {
      phoneErrorMsg = AppLocalization.of(context).translate("required");
    } else if (phoneController.text.length < 11) {
      phoneErrorMsg =
          AppLocalization.of(context).translate("mobile_length_not_valid");
    } else {
      phoneErrorMsg = null;
    }

    // businessActivity
    if (businessActivityController.text.isEmpty) {
      businessActivityErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (businessActivityController.text.length < 2) {
      businessActivityErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      businessActivityErrorMsg = null;
    }

    // description
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else if (descriptionController.text.length < 2) {
      descriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      descriptionErrorMsg = null;
    }

    // businessActivity
    if (businessDescriptionContrller.text.isEmpty) {
      businessDescriptionErrorMsg =
          AppLocalization.of(context).translate("required");
    } else if (businessDescriptionContrller.text.length < 2) {
      businessDescriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      businessDescriptionErrorMsg = null;
    }

    setState(() {});

    if (businessActivityErrorMsg == null &&
        phoneErrorMsg == null &&
        emailErrorMsg == null &&
        addressErrorMsg == null &&
        businessDescriptionErrorMsg == null &&
        descriptionErrorMsg == null &&
        profileImageErrorMsg == null &&
        photosErrorMsg == null) {
      setState(() {
        isLoading = true;
      });

      AppUtils.hideKeyboard(context);

      langs[0].title = titleController.text;
      langs[0].address = addressController.text;
      langs[0].description = descriptionController.text;
      langs[0].business_description = businessDescriptionContrller.text;
      langs[0].business_activity = businessActivityController.text;

      CreateCatalougeFormRequest request = CreateCatalougeFormRequest(
        email: emailController.text,
        categoryId: catalogueBloc.landing.value.data.firstWhere((element) => element.name == selectedCategory).id.toString(),
        phone: phoneController.text,
        city: selectedCityId,
        country: AppUtils.getCountryId(),
        governorate: selectedGovernorateId,
        lat: LATITUDE,
        long: LONGITUDE,
        gallery: photos,
        mainImage: profileImage,
        lang: langs,
      );

      print(request.toString());

      var response = await catalogueBloc.createCatalouge(request);
      print(response.toString());

      setState(() {
        isLoading = false;
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        AppUtils.showToast(
          msg: AppUtils.translate(
            context,
            'done',
          ),
          bgColor: mainColor,
        );

        Navigator.pop(context);
      } else {
        AppUtils.showToast(msg: response.data.toString());
      }
    }
  }
}
