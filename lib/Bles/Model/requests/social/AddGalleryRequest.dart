import 'dart:io';

import 'package:phinex/utils/consts.dart';
class AddGalleryRequest {
  int userID ;
  List<File> gallery;


  AddGalleryRequest(this.userID, this.gallery);

  Map toJson() => {
    "gallery": galleryToString(gallery),
  };
}