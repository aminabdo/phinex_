import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class PharmacistRegisterRequest extends BaseRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  String address;
  int city;
  int governorate;
  String commercialName;
  String description;
  String shortDescription;
  File profileImage;
  List<Pharmacy> pharmacies;

  static PharmacistRegisterRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmacistRegisterRequest pharmacistRegisterRequestBean =
        PharmacistRegisterRequest();
    pharmacistRegisterRequestBean.firstName = map['first_name'];
    pharmacistRegisterRequestBean.lastName = map['last_name'];
    pharmacistRegisterRequestBean.phone = map['phone'];
    pharmacistRegisterRequestBean.password = map['password'];
    pharmacistRegisterRequestBean.address = map['address'];
    pharmacistRegisterRequestBean.city = map['city'];
    pharmacistRegisterRequestBean.governorate = map['governorate'];
    pharmacistRegisterRequestBean.commercialName = map['commercial_name'];
    pharmacistRegisterRequestBean.description = map['description'];
    pharmacistRegisterRequestBean.shortDescription = map['short_description'];
    pharmacistRegisterRequestBean.profileImage = map['profile_image'];
    pharmacistRegisterRequestBean.pharmacies = List()
      ..addAll(
          (map['pharmacies'] as List ?? []).map((o) => Pharmacy.fromMap(o)));
    return pharmacistRegisterRequestBean;
  }

  Map toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "password": password,
        "address": address,
        "city": city,
        "governorate": governorate,
        "commercial_name": commercialName,
        "description": description,
        "short_description": shortDescription,
        "profile_image": imageToString(profileImage),
        "pharmacies": pharmacies,
      };

  @override
  String toString() {
    return 'PharmacistRegisterRequest{firstName: $firstName, lastName: $lastName, phone: $phone, password: $password, address: $address, city: $city, governorate: $governorate, commercialName: $commercialName, description: $description, shortDescription: $shortDescription, pharmacies: $pharmacies}';
  }
}

class Pharmacy {
  String title;
  int country;
  int governorate;
  int city;
  String address;
  String longitude;
  String latitude;
  int phone;
  int homeVisit;
  String deliveryStatus;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openAt;
  String closingAt;
  String description;
  String email;
  String website;
  File logoImage;
  File coverImage;
  List<File> gallery;

  Pharmacy(
      {this.title,
      this.country,
      this.governorate,
      this.city,
      this.address,
      this.longitude,
      this.latitude,
      this.phone,
      this.homeVisit,
      this.deliveryStatus,
      this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.openAt,
      this.closingAt,
      this.description,
      this.email = '',
      this.website = '',
      this.logoImage,
      this.coverImage,
      this.gallery});

  static Pharmacy fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Pharmacy pharmaciesBean = Pharmacy();
    pharmaciesBean.title = map['title'];
    pharmaciesBean.country = map['country'];
    pharmaciesBean.governorate = map['governorate'];
    pharmaciesBean.city = map['city'];
    pharmaciesBean.address = map['address'];
    pharmaciesBean.longitude = map['longitude'];
    pharmaciesBean.latitude = map['latitude'];
    pharmaciesBean.phone = map['phone'];
    pharmaciesBean.homeVisit = map['home_visit'];
    pharmaciesBean.deliveryStatus = map['delivery_status'];
    pharmaciesBean.saturday = map['saturday'];
    pharmaciesBean.sunday = map['sunday'];
    pharmaciesBean.monday = map['monday'];
    pharmaciesBean.tuesday = map['tuesday'];
    pharmaciesBean.wednesday = map['wednesday'];
    pharmaciesBean.thursday = map['thursday'];
    pharmaciesBean.friday = map['friday'];
    pharmaciesBean.openAt = map['open_at'];
    pharmaciesBean.closingAt = map['closing_at'];
    pharmaciesBean.description = map['description'];
    pharmaciesBean.email = map['email'];
    pharmaciesBean.website = map['website'];
    pharmaciesBean.logoImage = map['logo_image'];
    pharmaciesBean.coverImage = map['cover_image'];
    return pharmaciesBean;
  }

  @override
  String toString() {
    return 'Pharmacy{title: $title, country: $country, governorate: $governorate, city: $city, address: $address, longitude: $longitude, latitude: $latitude, phone: $phone, homeVisit: $homeVisit, deliveryStatus: $deliveryStatus, saturday: $saturday, sunday: $sunday, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, openAt: $openAt, closingAt: $closingAt, description: $description, email: $email, website: $website}';
  }

  Map toJson() => {
        "title": title,
        "country": country,
        "governorate": governorate,
        "city": city,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "phone": phone,
        "home_visit": homeVisit,
        "delivery_status": deliveryStatus,
        "saturday": saturday,
        "sunday": sunday,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "open_at": openAt,
        "closing_at": closingAt,
        "description": description,
        "email": email,
        "website": website,
        "logo_image": imageToString(logoImage),
        "cover_image": imageToString(coverImage),
        "gallery": galleryToString(gallery),
      };
}
