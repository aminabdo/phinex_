
import 'dart:io';

import 'package:phinex/utils/consts.dart';

class StoreCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  String address;
  File image;
  File coverImage;
  String commercialName;
  int categoryId;
  String description;
  int contactNumber;
  String email;
  String website;
  int city;
  int governorate;
  double addressLatitude;
  double addressLongitude;
  String openFromTime;
  String openToTime;
  int hotline;
  String deliveryStatus;


  StoreCreateRequest(
      {this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.address,
      this.image ,
      this.coverImage,
      this.commercialName,
      this.categoryId,
      this.description,
      this.contactNumber,
      this.email = '',
      this.website = '',
      this.city,
      this.governorate,
      this.addressLatitude,
      this.addressLongitude,
      this.openFromTime,
      this.openToTime,
      this.hotline,
      this.deliveryStatus});

  Map toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "password": password,
    "address": address,
    "image": imageToString(image),
    "cover_image": imageToString(coverImage),
    "commercial_name": commercialName,
    "category_id": categoryId,
    "description": description,
    "contact_number": contactNumber,
    "email": email,
    "website": website,
    "city": city,
    "governorate": governorate,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "open_from_time": openFromTime,
    "open_to_time": openToTime,
    "hotline": hotline,
    "delivery_status": deliveryStatus,
  };
}