import 'dart:io';

import 'package:phinex/utils/consts.dart';
class DoctorCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  File image;
  int categoryId;
  String commercialName;
  int homeVisit;
  String degree;
  String shortDescription;
  String description;
  int city;
  int governorate;
  String email;
  String website;
  List<Hospitals> hospitals;
  List<Clinics> clinics;

  @override
  String toString() {
    return 'DoctorCreateRequest{firstName: $firstName, lastName: $lastName, phone: $phone, password: $password, categoryId: $categoryId, commercialName: $commercialName, homeVisit: $homeVisit, degree: $degree, shortDescription: $shortDescription, description: $description, city: $city, governorate: $governorate, email: $email, website: $website, hospitals: $hospitals, clinics: $clinics}';
  }

  DoctorCreateRequest(
      {this.firstName = "dsadsa",
      this.lastName = "dsadsa",
      this.phone = "0231032310231",
      this.password = "123456798",
      this.image ,
      this.categoryId,
      this.commercialName,
      this.homeVisit,
      this.degree,
      this.shortDescription,
      this.description,
      this.city,
      this.governorate,
      this.email = '',
      this.website = '',
      this.hospitals,
      this.clinics});


  Map toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "password": password,
        "image": imageToString(image),
        "category_id": categoryId,
        "commercial_name": commercialName,
        "home_visit": homeVisit,
        "degree": degree,
        "short_description": shortDescription,
        "description": description,
        "city": city,
        "governorate": governorate,
        "email": email,
        "website": website,
        "hospitals": hospitals,
        "clinics": clinics,
      };
}

class WorkingDays {
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;

  @override
  String toString() {
    return 'WorkingDays{sunday: $sunday, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday}';
  }

  WorkingDays({this.sunday =0, this.monday =0, this.tuesday =0, this.wednesday =0,
      this.thursday =0, this.friday =0, this.saturday =0});

  static WorkingDays fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WorkingDays workingDaysBean = WorkingDays();
    workingDaysBean.sunday = map['sunday'];
    workingDaysBean.monday = map['monday'];
    workingDaysBean.tuesday = map['tuesday'];
    workingDaysBean.wednesday = map['wednesday'];
    workingDaysBean.thursday = map['thursday'];
    workingDaysBean.friday = map['friday'];
    workingDaysBean.saturday = map['saturday'];
    return workingDaysBean;
  }

  Map toJson() => {
        "sunday": sunday,
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "saturday": saturday,
      };
}

class Hospitals {

  String title;
  int governorate;
  int city;
  String website;
  String email;
  String description;
  String address;
  int categoryId;
  File logo;
  File coverImage;
  double longitude;
  double latitude;
  String type ="hospital";
  int phone;
  int regularPrice;
  int urgentPrice;
  int limit;
  String openAt;
  String closingAt;
  WorkingDays workingDays;
  List<File> gallery;
  List<Clinics> clinics;

  Hospitals({
    this.title,
    this.governorate,
    this.city,
    this.website = '',
    this.email = '',
    this.description,
    this.address,
    this.categoryId,
    this.logo,
    this.coverImage,
    this.longitude,
    this.latitude,
    this.type="hospital",
    this.phone,
    this.regularPrice,
    this.urgentPrice,
    this.limit,
    this.openAt,
    this.closingAt,
    this.workingDays,
    this.gallery,
    this.clinics,
  });

  Map toJson() => {
        "title": title,
        "governorate": governorate,
        "city": city,
        "website": website,
        "email": email,
        "description": description,
        "address": address,
        "category_id": categoryId,
        "logo": imageToString(logo),
        "cover_image": imageToString(coverImage),
        "longitude": longitude,
        "latitude": latitude,
        "type": type,
        "phone": phone,
        "regular_price": regularPrice,
        "urgent_price": urgentPrice,
        "limit": limit,
        "open_at": openAt,
        "closing_at": closingAt,
        "workingDays": workingDays,
        "gallery": galleryToString(gallery),
        "clinics": clinics,
      };

  @override
  String toString() {
    return 'Hospitals{title: $title, governorate: $governorate, city: $city, website: $website, email: $email, description: $description, address: $address, categoryId: $categoryId, logo: $logo, longitude: $longitude, latitude: $latitude, type: $type, phone: $phone, regularPrice: $regularPrice, urgentPrice: $urgentPrice, limit: $limit, openAt: $openAt, closingAt: $closingAt, workingDays: $workingDays, clinics: $clinics}';
  }
}

class Clinics {
  String title;
  int governorate;
  int city;
  String website;
  String email;
  String description = "test";
  String address;
  int categoryId;
  File logo;
  File coverImage;
  double longitude;
  double latitude;
  String type="clinic";
  int phone;
  int regularPrice;
  int urgentPrice;
  int limit;
  String openAt;
  String closingAt;
  WorkingDays workingDays;
  List<File> gallery;

  @override
  String toString() {
    return 'Clinics{title: $title, governorate: $governorate, city: $city, website: $website, email: $email, description: $description, address: $address, categoryId: $categoryId, logo: $logo, longitude: $longitude, latitude: $latitude, type: $type, phone: $phone, regularPrice: $regularPrice, urgentPrice: $urgentPrice, limit: $limit, openAt: $openAt, closingAt: $closingAt, workingDays: $workingDays}';
  }

  Clinics(
      {this.title,
      this.governorate,
      this.city,
      this.website = '',
      this.email = '',
      this.description = "description",
      this.address,
      this.categoryId=18,
      this.logo,
      this.coverImage,
      this.longitude,
      this.latitude,
      this.type="clinic",
      this.phone,
      this.regularPrice,
      this.urgentPrice,
      this.limit = 5000,
      this.openAt,
      this.closingAt,
      this.workingDays,
      this.gallery});


  Map toJson() {
    Map map = {
      "title": title,
      "governorate": governorate,
      "city": city,
      "website": website,
      "email": email,
      "description": description,
      "address": address,
      "category_id": categoryId,
      "logo": imageToString(logo),
      "cover_image": imageToString(coverImage),
      "longitude": longitude,
      "latitude": latitude,
      "type": type,
      "phone": phone,
      "regular_price": regularPrice,
      "urgent_price": urgentPrice,
      "limit": limit,
      "open_at": openAt,
      "closing_at": closingAt,
      "workingDays": workingDays,
      "gallery": galleryToString(gallery),
    };
    map.addAll(null);
    return map ;
  }
}

