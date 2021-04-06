import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'app_localization.dart';

Color scaffoldBackgroundColor = Color(0xffFCFCFC);
Color deepBlueColor = Color(0xff16135A);
Color mainColor = Color(0xffF12E00);
Color goldColor = Colors.yellow[800];

final ScrollPhysics bouncingScrollPhysics = BouncingScrollPhysics();
final String APP_NAME = 'Phinex';
final String APP_NAME_AR = 'فينيكس';
final String MAP_KEY= 'AIzaSyAoTwcHKgeZHNOLykqqk2RTKAAlbGz8PGI';

final bool showDevicePreview = false;

final String Type = 'user';
final String Channel = 'mobile';

final String LONGITUDE = "1.2220000";
final String LATITUDE = "7.2554000";

String translate(BuildContext context, String key) {
  return AppLocalization.of(context).translate(key);
}

class RateObjectName {
  static String product = 'product';
  static String vendor = 'vendor';
  static String doctor = 'doctor';
  static String technician = 'technician';
  static String catalouge = 'catalouge';
  static String restaurant = 'restaurant';
  static String pharmacy = 'pharmacy';
  static String clinic = 'clinic';
}

class MedicalObjectName {
  static String spa = 'spa';
  static String clinics = 'clinics';
  static String clinic = 'clinic';
  static String laboratories = 'laboratories';
  static String hospitals = 'hospitals';
  static String hospital = 'hospital';
  static final String CLINIC_SPECIALTY = 'clinics/specialty/';
}

imageToString(File img) {
  List<int> imageBytes = img.readAsBytesSync();

  String imageString =
      "data:image/png;base64," + base64Encode(imageBytes) + "=";
  return imageString;
}

galleryToString(List<File> img) {
  List<String> galleryList = [];

  for (File file in img) {
    List<int> imageBytes = file.readAsBytesSync();

    String imageString =
        "data:image/png;base64," + base64Encode(imageBytes) + "=";

    galleryList.add(imageString);
  }
  return galleryList;
}

class SharedPreferencesKeys {
  static const String date_login = 'date_login';
  static const String lang_code = 'langCode';
  static const String currency = 'currency';
  static const String current_user = 'currentUser';

}