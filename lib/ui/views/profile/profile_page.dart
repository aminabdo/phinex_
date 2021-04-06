import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/social/UpdateUserProfile.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class ProfilePage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  bool gotData = false;
  bool uploadImage = false;
  bool gotData2 = false;
  File profileImage;

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  List<String> governoratesList = [];
  List<String> cityList = [];

  TextEditingController firstNameController = TextEditingController(text: AppUtils.userData.firstName);
  TextEditingController lastNameController = TextEditingController(text: AppUtils.userData.lastName);
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController governmentController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String firstNameErrorMsg;
  String lastNameErrorMsg;
  String emailErrorMsg;

  @override
  void initState() {
    super.initState();
    socialBloc.getUserProfile(AppUtils.userData.id);
    if (generalBloc.generalGovModel?.value == null) {
      generalBloc.getModelGov();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('my_profile'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
        },
        actions: [
          FlatButton(
            onPressed: isLoading
                ? null
                : () {
                    updateUserData();
                  },
            child: Text(
              '${AppLocalization.of(context).translate('save')}',
              style: TextStyle(
                color: isLoading ? Colors.grey : mainColor,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
          return false;
        },
        child: StreamBuilder<GeneralModelGovResponse>(
          stream: generalBloc.generalGovModel.stream,
          builder: (context, snapshot) {
            if (generalBloc.loading.value) {
              return Loader();
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                if (!gotData) {
                  snapshot.data.data.governorates.forEach((element) {
                    governoratesList.add(element.name);
                  });

                  if (governoratesList.isNotEmpty) {
                    selectedGovernorate = governoratesList[0];
                  }

                  var government = snapshot.data.data.governorates.firstWhere((element) => element.name == selectedGovernorate);
                  government.cities.forEach((element) {
                    cityList.add(element.name);
                  });

                  if (cityList.isNotEmpty) {
                    selectedCity = cityList[0];
                  }

                  var currentGovernorate = snapshot.data.data.governorates.firstWhere(
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
              }

              return StreamBuilder<UserProfileResponse>(
                stream: socialBloc.userProfile.stream,
                builder: (context, userSnapshot) {
                  if (socialBloc.loading.value) {
                    return Loader();
                  } else {

                    if (userSnapshot.hasData && userSnapshot.data != null) {
                      var userDetails = userSnapshot.data.data?.details?.userDetails;
                      if (!gotData2) {

                        gotData2 = true;
                        emailController.text = userDetails?.email;
                        addressController.text = userDetails?.address;

                        snapshot.data.data.governorates.forEach((element) {
                          if (element.id.toString() == userDetails.governorate.toString()) {
                            selectedGovernorate = element.name;
                            selectedGovernorateId = element.id.toString();

                            element.cities.forEach((element) {
                              cityList.add(element.name);
                            });

                            if (cityList.isNotEmpty) {
                              selectedCity = cityList[0];
                            }

                            element.cities.forEach((element) {
                                if (element.name == selectedCity) {
                                  selectedCityId = element.id.toString();
                                }
                              },
                            );
                          }
                        });
                      }

                      return LoadingOverlay(
                        isLoading: isLoading,
                        progressIndicator: Loader(),
                        color: Colors.white,
                        opacity: .5,
                        child: SingleChildScrollView(
                          physics: bouncingScrollPhysics,
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(18)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: CircleAvatar(
                                        radius: 45,
                                        backgroundImage: userDetails == null ||
                                                userDetails?.imageUrl == '' ||
                                                userDetails?.imageUrl == null
                                            ? profileImage == null
                                                ? AssetImage(
                                                    'assets/images/avatar.png',
                                                  )
                                                : FileImage(profileImage)
                                            : CachedNetworkImageProvider(
                                                userDetails?.imageUrl,
                                              ),
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
                                        AppLocalization.of(context)
                                            .translate('upload_photo'),
                                        style: TextStyle(
                                          color: mainColor,
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
                                          title: AppLocalization.of(context)
                                              .translate('first_name'),
                                          hintText: AppUtils.userData.firstName,
                                          controller: firstNameController,
                                          errorMessage: firstNameErrorMsg,
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(16),
                                      ),
                                      Expanded(
                                        child: MyTextFormField(
                                          title: AppLocalization.of(context)
                                              .translate('last_name'),
                                          hintText: AppUtils.userData.lastName,
                                          controller: lastNameController,
                                          errorMessage: lastNameErrorMsg,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(12),
                                  ),
                                  MyTextFormField(
                                    title: AppLocalization.of(context)
                                        .translate('email'),
                                    controller: emailController,
                                    errorMessage: emailErrorMsg,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(12),
                                  ),
                                  // MyTextFormField(
                                  //   title: AppLocalization.of(context)
                                  //       .translate('mobile_number'),
                                  //   hintText: AppUtils.userData.phone,
                                  // ),
                                  // SizedBox(
                                  //   height: ScreenUtil().setHeight(12),
                                  // ),
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
                                        items: governoratesList
                                            .map((String value) {
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
                                                element.name ==
                                                selectedGovernorate,
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
                                                element.name ==
                                                selectedGovernorate,
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
                                    title: AppLocalization.of(context)
                                        .translate('address_details'),
                                    controller: addressController,
                                  )
                                ],
                              ),
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
      ),
    );
  }

  void getImage() async {
    bool permissionIsGranted = await AppUtils.askPhotosPermission();
    if (permissionIsGranted) {
      try {
        var selectedImage = await AppUtils.getImage(1);

        if (selectedImage != null) {
          // print file path
          var path = await FlutterAbsolutePath.getAbsolutePath(
            selectedImage[0].identifier,
          );

          profileImage = File(path);
          setState(() {});
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void updateUserData() async {
    if (firstNameController.text.isEmpty) {
      firstNameErrorMsg = AppUtils.translate(context, 'required');
    } else {
      firstNameErrorMsg = null;
    }

    if (lastNameController.text.isEmpty) {
      lastNameErrorMsg = AppUtils.translate(context, 'required');
    } else {
      lastNameErrorMsg = null;
    }

    if (emailController.text.isNotEmpty) {
      if (!PatternUtils.emailIsValid(email: emailController.text)) {
        emailErrorMsg = AppUtils.translate(context, 'enter_valid_email');
      } else {
        emailErrorMsg = null;
      }
    }

    setState(() {});

    if (firstNameErrorMsg == null &&
        lastNameErrorMsg == null &&
        emailErrorMsg == null) {
      isLoading = true;
      setState(() {});

      if(profileImage != null) {
       print('==============');
        await socialBloc.updateUserProfileImage(UpdateUserProfileRequest.image(image: profileImage, userId: AppUtils.userData.id));
      }

      await socialBloc.updateUserProfile(UpdateUserProfileRequest(
        email: emailController.text,
        userId: AppUtils.userData.id,
        image: profileImage,
        governorate: selectedGovernorateId,
        city: selectedCityId,
        address: addressController.text,
        country: AppUtils.getCountryId(),
        image_url: profileImage,
        coverImage: profileImage,
        jobTitle: '',
        description: '',
        education: '',
      ));

      var userData = socialBloc.userProfile.value.data.details;
      AppUtils.userData.firstName = userData.firstName;
      AppUtils.userData.lastName = userData.lastName;
      AppUtils.userData.username = userData.username;
      await AppUtils.saveUserData(AppUtils.userData);

      isLoading = false;
      setState(() {});

      // Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
    }
  }
}
