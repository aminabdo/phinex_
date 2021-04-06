import 'dart:io';

import 'package:phinex/utils/consts.dart';

class ProfesionCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  File image;
  int categoryId;
  String commercialName;
  String shortDescription;
  String description;
  int governorate;
  int city;
  List<WorkshopsBean> workshops;

  Map toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "password": password,
    "image": imageToString(image),
    "category_id": categoryId,
    "commercial_name": commercialName,
    "short_description": shortDescription,
    "description": description,
    "governorate": governorate,
    "city": city,
    "workshops": workshops,
  };
}


class WorkshopsBean {
  String title;
  int governorate;
  int city;
  String address;
  double long;
  double lat;
  int phone;
  String description;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openFrom;
  String openTo;

  Map toJson() => {
    "title": title,
    "governorate": governorate,
    "city": city,
    "address": address,
    "long": long,
    "lat": lat,
    "phone": phone,
    "description": description,
    "saturday": saturday,
    "sunday": sunday,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "openFrom": openFrom,
    "openTo": openTo,
  };
}