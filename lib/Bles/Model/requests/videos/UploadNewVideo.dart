import 'dart:io';

import 'package:dio/dio.dart';

class UploadNewVideoRequest {
  String title;
  String description;
  String userId;
  File videoFile;

  UploadNewVideoRequest(
    this.title,
    this.description,
    this.userId,
    this.videoFile,
  );


  toJson() =>{
    'title':title,
    'userId':description,
    'userId':userId,
  };
  toUpload() async{

    FormData formData = FormData.fromMap({
      "video": await MultipartFile.fromFile(this.videoFile.path),
      "user_id": this.userId,
      "title": this.title,
      "description": this.description,
    });


    return formData;
  }



}
