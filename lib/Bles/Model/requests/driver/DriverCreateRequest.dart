import 'dart:io';
import 'package:phinex/utils/consts.dart';

class DriverCreateRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  File image;
  String licenseNumber;
  File licenseImage;
  String licenseExpiryDate;
  File crimeRecordsImage;
  int governorate;
  int city;
  String type;
  String licensePlate;
  File imageLicenseFront;
  File imageLicenseBack;
  int carModelId;
  int manufacturerYear;


  DriverCreateRequest(
      {this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.image,
      this.licenseNumber,
      this.licenseImage,
      this.licenseExpiryDate,
      this.crimeRecordsImage,
      this.governorate,
      this.city,
      this.type = 'rental',
      this.licensePlate,
      this.imageLicenseFront,
      this.imageLicenseBack,
      this.carModelId,
      this.manufacturerYear});

  static DriverCreateRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DriverCreateRequest driverCreateRequestBean = DriverCreateRequest();
    driverCreateRequestBean.firstName = map['first_name'];
    driverCreateRequestBean.lastName = map['last_name'];
    driverCreateRequestBean.phone = map['phone'];
    driverCreateRequestBean.password = map['password'];
    driverCreateRequestBean.image = map['image'];
    driverCreateRequestBean.licenseNumber = map['license_number'];
    driverCreateRequestBean.licenseImage = map['license_image'];
    driverCreateRequestBean.licenseExpiryDate = map['license_expiry_date'];
    driverCreateRequestBean.crimeRecordsImage = map['crime_records_image'];
    driverCreateRequestBean.governorate = map['governorate'];
    driverCreateRequestBean.city = map['city'];
    driverCreateRequestBean.type = map['type'];
    driverCreateRequestBean.licensePlate = map['license_plate'];
    driverCreateRequestBean.imageLicenseFront = map['image_license_front'];
    driverCreateRequestBean.imageLicenseBack = map['image_license_back'];
    driverCreateRequestBean.carModelId = map['car_model_id'];
    driverCreateRequestBean.manufacturerYear = map['manufacturer_year'];
    return driverCreateRequestBean;
  }

  Map toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "password": password,
    "image": imageToString(image),
    "license_number": licenseNumber,
    "license_image": imageToString(licenseImage),
    "license_expiry_date": licenseExpiryDate,
    "crime_records_image": imageToString(crimeRecordsImage),
    "governorate": governorate,
    "city": city,
    "type": type,
    "license_plate": licensePlate,
    "image_license_front": imageToString(imageLicenseFront),
    "image_license_back": imageToString(imageLicenseBack),
    "car_model_id": carModelId,
    "manufacturer_year": manufacturerYear,
  };
}