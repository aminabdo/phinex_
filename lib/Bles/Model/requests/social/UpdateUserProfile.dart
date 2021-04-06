import 'dart:io';

import 'package:phinex/utils/consts.dart';

class UpdateUserProfileRequest {
  int userId;
  dynamic imageId;
  String email;
  String country;
  String governorate;
  String city;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  File image;
  File coverImage;
  String education;
  String jobTitle;
  String description;
  dynamic friendRecordId;
  String password;
  File cover_image;
  File image_url;

  UpdateUserProfileRequest({
    this.userId,
    this.email,
    this.country,
    this.governorate,
    this.city,
    this.address,
    this.image,
    this.coverImage,
    this.education,
    this.jobTitle,
    this.description,
    this.password,
    this.cover_image,
    this.image_url,
  });

  UpdateUserProfileRequest.image({this.userId, this.image});

  UpdateUserProfileRequest.coverImage({this.userId, this.coverImage});

  Map toJson() => {
        "education": education,
        "job_title": jobTitle,
        "country": country,
        "governorate": governorate,
        "city": city,
        "description": description,
        "address": address,
        "email": email,
        "password": this.password,
      };

  Map toJsonPassword() => {
        "password": this.password,
      };

  Map toJsonImage() => {
        "image": imageToString(image),
      };

  Map toJsonCoverImage() => {
        "cover_image": imageToString(coverImage),
      };
}
