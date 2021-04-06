import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';

class RestaurantsByCatResponse {
  List<RestaurantsBean> data;
  dynamic message;
  int code;

  static RestaurantsByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RestaurantsByCatResponse restaurantsByCatBean = RestaurantsByCatResponse();
    restaurantsByCatBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => RestaurantsBean.fromMap(o))
    );
    restaurantsByCatBean.message = map['message'];
    restaurantsByCatBean.code = map['code'];
    return restaurantsByCatBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
