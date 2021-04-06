import 'dart:io';

import 'package:phinex/utils/consts.dart';

class RealStateCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  String commercialName;
  File image;
  String email;
  String website;
  String description;
  int contactPerson;
  int contactNumber;
  int governorate;
  int city;
  String address;
  int hotline;
  double addressLatitude;
  double addressLongitude;

  Map toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "password": password,
    "commercial_name": commercialName,
    "image": imageToString(image),
    "email": email,
    "website": website,
    "description": description,
    "contact_person": contactPerson,
    "contact_number": contactNumber,
    "governorate": governorate,
    "city": city,
    "address": address,
    "hotline": hotline,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
  };
}