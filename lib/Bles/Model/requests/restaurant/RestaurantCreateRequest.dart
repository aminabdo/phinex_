import 'dart:io';

import 'package:phinex/utils/consts.dart';

class RestaurantCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  String address;
  File profileImage;
  String commercialName;
  String shortDescription;
  String description;
  int city;
  int governorate;
  List<Restaurant> restaurants;

  RestaurantCreateRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.address,
    this.profileImage,
    this.commercialName,
    this.shortDescription,
    this.description,
    this.city,
    this.governorate,
    this.restaurants,
  });

  Map toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "password": password,
        "address": address,
        "profile_image": imageToString(profileImage),
        "commercial_name": commercialName,
        "short_description": shortDescription,
        "description": description,
        "city": city,
        "governorate": governorate,
        "restaurants": restaurants,
      };
}

class Restaurant {
  String title;
  int governorate;
  int city;
  String website;
  String email;
  String description;
  String address;
  File logo;
  File coverImage;
  double longitude;
  double latitude;
  int phone;
  String deliveryStatus;
  String openAt;
  String closingAt;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  List<File> gallery;

  Restaurant({
    this.title,
    this.governorate,
    this.city,
    this.website = '',
    this.email = '',
    this.description,
    this.address,
    this.logo,
    this.coverImage,
    this.longitude,
    this.latitude,
    this.phone,
    this.deliveryStatus,
    this.openAt,
    this.closingAt,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.gallery,
  });

  Map toJson() => {
        "title": title,
        "governorate": governorate,
        "city": city,
        "website": website,
        "email": email,
        "description": description,
        "address": address,
        "logo": imageToString(logo),
        "cover_image": imageToString(coverImage),
        "longitude": longitude,
        "latitude": latitude,
        "phone": phone,
        "delivery_status": deliveryStatus,
        "open_at": openAt,
        "closing_at": closingAt,
        "sunday": sunday,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
        "gallery": galleryToString(gallery),
      };
}
