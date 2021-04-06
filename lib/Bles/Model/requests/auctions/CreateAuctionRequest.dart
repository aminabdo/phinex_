import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class CreateAuctionRequest extends BaseRequest {
  int categoryId;
  String description;
  List<File> gallery;
  double incrementValue;
  File mainImage;
  double openPrice;
  String opensFrom;
  String endsAt;
  int sellerId;
  String title;

  CreateAuctionRequest(
      {this.categoryId,
      this.description,
      this.gallery,
      this.incrementValue,
      this.mainImage,
      this.openPrice,
      this.opensFrom,
      this.sellerId,
      this.endsAt,
      this.title,
      });

  Map toJson() => {
        "category_id": categoryId,
        "description": description,
        "gallery": galleryToString(gallery),
        "increment_value": incrementValue,
        "main_image": imageToString(mainImage),
        "open_price": openPrice,
        "opens_from": opensFrom,
        "seller_id": sellerId,
        "title": title,
        "ends_at": endsAt,
      };

  @override
  String toString() {
    return 'CreateAuctionRequest{categoryId: $categoryId, description: $description, incrementValue: $incrementValue, openPrice: $openPrice, opensFrom: $opensFrom, endsAt: $endsAt, sellerId: $sellerId, title: $title}';
  }
}
