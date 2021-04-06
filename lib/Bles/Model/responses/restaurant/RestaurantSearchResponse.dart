import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';

/// data : [{"title":"KFC","user_id":357,"logo_id":3129,"cover_image_id":3130,"country":64,"governorate":1048,"city":15420,"address":"20 ST El Tahrir - Doqqi","longitude":"1.2220000","latitude":"7.2554000","phone":1919,"delivery_status":"as_open","saturday":1,"sunday":1,"monday":1,"tuesday":1,"wednesday":1,"thursday":1,"friday":1,"open_at":"12:00:00","closing_at":"00:00:00","RestaurantId":9,"image_url":"https://images.phinex.net/storage/app/public/images/2020-11/25-Wed/kfc-logo-1606301134.png"},{"title":"KFC2","user_id":229,"logo_id":3131,"cover_image_id":3132,"country":64,"governorate":1048,"city":15420,"address":"6 October","longitude":"1.2220000","latitude":"7.2554000","phone":5984874,"delivery_status":"as_open","saturday":1,"sunday":1,"monday":1,"tuesday":1,"wednesday":1,"thursday":1,"friday":1,"open_at":"15:03:00","closing_at":"02:04:00","RestaurantId":10,"image_url":"https://images.phinex.net/storage/app/public/images/2020-11/25-Wed/kfc2-logo-1606301371.png"}]
/// message : null
/// code : 200

class RestaurantSearchResponse {
  List<RestaurantsBean> data;
  dynamic message;
  int code;

  static RestaurantSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RestaurantSearchResponse restaurantSearchResponseBean = RestaurantSearchResponse();
    restaurantSearchResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => RestaurantsBean.fromMap(o))
    );
    restaurantSearchResponseBean.message = map['message'];
    restaurantSearchResponseBean.code = map['code'];
    return restaurantSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}