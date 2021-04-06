import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';

import 'DetailsBean.dart';
import 'RatingBean.dart';

class VendorBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  DetailsBean details;
  List<RatingBean> rating;
  List<ProductsBean> products;

  static VendorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VendorBean dataBean = VendorBean();
    dataBean.id = map['id'];
    dataBean.firstName = map['first_name'];
    dataBean.lastName = map['last_name'];
    dataBean.username = map['username'];
    dataBean.phone = map['phone'];
    dataBean.verificationCode = map['verification_code'];
    dataBean.apiToken = map['api_token'];
    dataBean.phoneVerifiedAt = map['phone_verified_at'];
    dataBean.type = map['type'];
    dataBean.chanel = map['chanel'];
    dataBean.details = DetailsBean.fromMap(map['details']);
    dataBean.rating = List()..addAll(
        (map['rating'] as List ?? []).map((o) => RatingBean.fromMap(o))
    );
    dataBean.products = List()..addAll(
        (map['products'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "phone": phone,
    "verification_code": verificationCode,
    "api_token": apiToken,
    "phone_verified_at": phoneVerifiedAt,
    "type": type,
    "chanel": chanel,
    "details": details,
    "rating": rating,
    "products": products,
  };
}
