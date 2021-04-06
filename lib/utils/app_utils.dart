import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/widgets/app_dialog.dart';
import 'package:phinex/ui/widgets/need_to_register_dialog.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/UserBean.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localization.dart';
import 'consts.dart';

class AppUtils {
  static UserData userData;
  PermissionStatus status;

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static showToast({@required msg, Color bgColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor ?? Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void clearUserData() async {
    await (await SharedPreferences.getInstance()).remove(SharedPreferencesKeys.current_user);
  }

  static clearLanguage() async {
    await (await SharedPreferences.getInstance()).remove(SharedPreferencesKeys.lang_code);
  }

  static clearCurrency() async {
    await (await SharedPreferences.getInstance()).remove('currency');
  }

  static showNeedToRegisterDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => NeedToCreateAccountDialogContent(),
    );
  }

  static showAppDialog(BuildContext context, String text) async {
    await showDialog(context: context, builder: (context) => AppDialogContent(text: text),);
  }

  // method to save last user login data
  static saveUserData(UserData responseBody) {
    SharedPreferences.getInstance().then((pref) {
      String data = jsonEncode(responseBody);
      pref.setString(SharedPreferencesKeys.current_user, data);
    });
  }

  // method to load last user login data
  static Future<UserData> getUserData() async {
    UserData currentUser;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(SharedPreferencesKeys.current_user) == null) {
      return null;
    }
    Map<String, dynamic> currentUserData =
    json.decode(pref.getString(SharedPreferencesKeys.current_user));
    currentUser = UserData.fromMap(currentUserData);
    return currentUser;
  }

  // true if granted : false if denied
  static Future<bool> askPhotosPermission() async {
    bool permissionState = false;
    await PermissionHandler().requestPermissions([
      PermissionGroup.photos,
    ]).then(
          (Map<PermissionGroup, PermissionStatus> map) {
        if (map[PermissionGroup.photos] == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );

    print('state of permission >>>> $permissionState');
    return permissionState;
  }

  // true if granted : false if denied
  static Future<bool> askCameraPermission() async {
    bool permissionState = false;
    await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]).then(
          (Map<PermissionGroup, PermissionStatus> map) {
        if (map[PermissionGroup.camera] == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );

    print('state of permission >>>> $permissionState');
    return permissionState;
  }

  // true if granted : false if denied
  static Future<bool> checkPermissionState(PermissionGroup permissions) async {
    bool permissionState = false;
    await PermissionHandler().checkPermissionStatus(permissions).then(
          (state) {
        if (state == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );
    return permissionState;
  }

  // true if granted : false if denied
  static Future<bool> askLocationPermission() async {
    bool permissionState = false;
    await PermissionHandler().requestPermissions([
      PermissionGroup.location,
    ]).then(
          (Map<PermissionGroup, PermissionStatus> map) {
        if (map[PermissionGroup.location] == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );

    print('state of permission >>>> $permissionState');
    return permissionState;
  }

  static Future<List<Asset>> getImage(int maxNumber) async {
    bool permissionIsGranted = await AppUtils.askPhotosPermission();
    if (permissionIsGranted) {
      try {
        var selectedImage = await MultiImagePicker.pickImages(
          maxImages: maxNumber,
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

        return selectedImage;
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      AppUtils.showToast(msg: 'Accept Permission First');
      return null;
    }
  }

  static void exitFromApp() {
    exit(0);
  }

  static String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  static Future<void> saveLoginDate(String date) async {
    (await SharedPreferences.getInstance()).setString(SharedPreferencesKeys.date_login, date);
  }

  static Future<String> getLoginDate() async {
    return (await SharedPreferences.getInstance()).getString(SharedPreferencesKeys.date_login,);
  }

  static double calculateDistanceBetween2Points(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String getRandomId() {
    return (Random().nextInt(1000000) + 1000).toString();
  }

  // country section
  static String country;

  static Future<String> loadSavedCountry() async {
    country = (await SharedPreferences.getInstance()).getString('country');
    return country;
  }

  static saveCountry(String code) async {
    (await SharedPreferences.getInstance()).setString('country', code);
  }

  static String getCountry() {
    return country;
  }

  // currency section
  static String currency;

  static Future<String> loadSavedCurrency() async {
    currency = (await SharedPreferences.getInstance()).getString('currency');
    return currency;
  }

  static saveCurrency(String currency) async {
    (await SharedPreferences.getInstance()).setString('currency', currency);
  }

  static String getCurrency() {
    return currency;
  }

  // language section
  static String language;

  static Future<String> loadSavedLanguage() async {
    language = (await SharedPreferences.getInstance()).getString('langCode');
    return language;
  }

  static saveLanguage(String language) async {
    (await SharedPreferences.getInstance()).setString('langCode', language);
  }

  static String getLanguage() {
    return language;
  }

  static String getCountryId() {
    String countryId = '';
     generalBloc.countries.value.data.forEach((element) {
        if (element.sortname.toUpperCase() == AppUtils.country.toUpperCase()) {
          countryId = element.id.toString();
        }
      },
    );

    return countryId;
  }

  static List<String> getNewsCat(BuildContext context) {
    List<String> catNews = [];
    catNews.add(AppUtils.translate(context, 'general'));
    catNews.add(AppUtils.translate(context, 'business1'));
    catNews.add(AppUtils.translate(context, 'entertainment'));
    catNews.add(AppUtils.translate(context, 'health'));
    catNews.add(AppUtils.translate(context, 'science'));
    catNews.add(AppUtils.translate(context, 'sports'));
    catNews.add(AppUtils.translate(context, 'technology'));

    return catNews;
  }

  static String newsApiKey = "e17973d784244ad2996849eb3d0299e5";

  static Map<String, int> catalogueParent = {
    "sports": 20014,
    "festival": 20015,
    "shipping": 20016,
    "education": 20017,
    "holidays": 20018,
    "security": 20019,
  };
}
