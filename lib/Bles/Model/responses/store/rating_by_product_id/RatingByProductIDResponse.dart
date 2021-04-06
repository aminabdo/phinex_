import 'package:phinex/Bles/Model/responses/store/single_product/RatesBean.dart';

class RatingByProductIDResponse {
  List<RatesBean> data;
  dynamic message;
  int code;

  static RatingByProductIDResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RatingByProductIDResponse ratingByProductIDResponseBean = RatingByProductIDResponse();
    ratingByProductIDResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => RatesBean.fromMap(o))
    );
    ratingByProductIDResponseBean.message = map['message'];
    ratingByProductIDResponseBean.code = map['code'];
    return ratingByProductIDResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
