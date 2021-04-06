
import 'dart:io';

import 'package:phinex/utils/consts.dart';

class CarRentalCreateRequest {
  String userId;
  String title;
  String rentalPeriod;
  String rentalPricePerPeriod;
  String transmission;
  String color;
  String hasDriver;
  String bodyType;
  String description;
  String carModelId;
  String manufacturerYear;
  String city;
  String country;
  String governorate;
  String phone;
  File main_image;
  List<File> gallery;

  CarRentalCreateRequest(
      {this.userId,
      this.title,
      this.rentalPeriod,
      this.rentalPricePerPeriod,
      this.transmission,
      this.color,
      this.hasDriver,
      this.bodyType,
      this.description,
      this.carModelId,
      this.manufacturerYear,
      this.city,
      this.country,
      this.governorate,
      this.phone,
      this.main_image,
      this.gallery});

  static CarRentalCreateRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CarRentalCreateRequest carRentalCreateRequestBean = CarRentalCreateRequest();
    carRentalCreateRequestBean.userId = map['user_id'];
    carRentalCreateRequestBean.title = map['title'];
    carRentalCreateRequestBean.rentalPeriod = map['rental_period'];
    carRentalCreateRequestBean.rentalPricePerPeriod = map['rental_price_per_period'];
    carRentalCreateRequestBean.transmission = map['transmission'];
    carRentalCreateRequestBean.color = map['color'];
    carRentalCreateRequestBean.hasDriver = map['has_driver'];
    carRentalCreateRequestBean.bodyType = map['body_type'];
    carRentalCreateRequestBean.description = map['description'];
    carRentalCreateRequestBean.carModelId = map['car_model_id'];
    carRentalCreateRequestBean.manufacturerYear = map['manufacturer_year'];
    carRentalCreateRequestBean.city = map['city'];
    carRentalCreateRequestBean.country = map['country'];
    carRentalCreateRequestBean.governorate = map['governorate'];
    carRentalCreateRequestBean.phone = map['phone'];
    return carRentalCreateRequestBean;
  }

   toJson() => {
    "user_id": userId,
    "title": title,
    "rental_period": rentalPeriod,
    "rental_price_per_period": rentalPricePerPeriod,
    "transmission": transmission,
    "color": color,
    "has_driver": hasDriver,
    "body_type": bodyType,
    "description": description,
    "car_model_id": carModelId,
    "manufacturer_year": manufacturerYear,
    "city": city,
    "country": country,
    "governorate": governorate,
    "phone": phone,
    "main_image": imageToString(this.main_image),
    "gallery": galleryToString(this.gallery),
  };
}